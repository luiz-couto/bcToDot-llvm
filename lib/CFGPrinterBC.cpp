#include "CFGPrinterBC.hpp"
#include "llvm/Support/raw_ostream.h"
#include <map>

#include "llvm/IR/Constants.h"
#include "llvm/IR/Function.h"
#include "llvm/IR/InstrTypes.h"
#include "llvm/IR/PassManager.h"
#include "llvm/IR/Value.h"
#include "llvm/IRReader/IRReader.h"
#include "llvm/Passes/PassBuilder.h"
#include "llvm/Passes/PassPlugin.h"
#include "llvm/Support/Casting.h"
#include "llvm/Support/CommandLine.h"

#include "llvm/Support/SourceMgr.h"

using namespace llvm;

/// A category for the options specified for this tool.
static cl::OptionCategory CFGPrinterBCCategory("addconst pass options");

/// A required argument that specifies the module that will be transformed.
static cl::opt<std::string> InputModule(cl::Positional,
                                        cl::desc("<Input module>"),
                                        cl::value_desc("bitcode filename"),
                                        cl::init(""), cl::Required,
                                        cl::cat(CFGPrinterBCCategory));

/// An optional argument that specifies the name of the output file.
static cl::opt<std::string> OutputModule("o", cl::Positional,
                                         cl::desc("<Output module>"),
                                         cl::value_desc("dot file name"),
                                         cl::init("out.dot"),
                                         cl::cat(CFGPrinterBCCategory));

namespace cfgprinterbc {

std::string genOpStr(Value *operand) {
    if (isa<Function>(operand)) return "@" + operand->getName().str();

    if (isa<BasicBlock>(operand)) return operand->getName().str();

    if (ConstantInt *CI = dyn_cast<ConstantInt>(operand)) return std::to_string(CI->getZExtValue());

    if (ConstantExpr *CE = dyn_cast<ConstantExpr>(operand)){
        std::string rep = " (";
        for (unsigned int j=0; j < CE->getNumOperands(); j++) {
            rep += genOpStr(CE->getOperand(j));
        }
        return rep + ")";
    }

    if (operand->hasName()) return "%" + operand->getName().str();

    return "";
}

void CFGPrinterBCPass::printFunctionName(Function &F) {
    //OS << "digraph \"CFG for " << "'" << F.getName().str() << "'" << " function\" {" << '\n';
    dotStr = dotStr + "digraph \"CFG for " + "'" + F.getName().str() + "'" + " function\" {" + '\n';
}

void CFGPrinterBCPass::printBasicBlock(BasicBlock &BB) {
    std::string res = BB.getName().str() + " [shape=record, label=\"{" + BB.getName().str() + ":\\l\\l\n";
    //OS << res;
    dotStr += res;

    for (Instruction &I : BB) {
        printInstruction(I);
    }
    //OS << "}\"];\n";
    dotStr += "}\"];\n";
}

void CFGPrinterBCPass::printInstruction(Instruction &I) {
    std::string result;

    if (!I.getType()->isVoidTy()) {
        result += "%" + I.getName().str() + " = ";
    }

    result += I.getOpcodeName();

    if (PHINode *PN = dyn_cast<PHINode>(&I)) {

        for (unsigned int i = 0; i < PN->getNumIncomingValues(); i++) {
            result += std::string(i ? ", " : "");
            result += " [" + genOpStr(PN->getIncomingValue(i));
            result += ", " + genOpStr(PN->getIncomingBlock(i)) + " ]";
        }

        result += "\\l\n";
        //OS << result;
        dotStr += result;
        return;
    }

    if (I.getOpcode() == Instruction::Call) {
        result += " " + genOpStr(I.getOperand(I.getNumOperands() - 1));
        result += "(";

        for (unsigned int i = 0; i < I.getNumOperands() - 1; ++i) {
            result += genOpStr(I.getOperand(i));
            if (i < I.getNumOperands() - 2) {
                result += ", ";
            }
        }
        
        result += ")\\l";
        //OS << result;
        dotStr += result;
        return;
    }

    for (unsigned int i = 0; i < I.getNumOperands(); i++) {
        result += " " + genOpStr(I.getOperand(i));
    }

    result += "\\l\n";
    OS << result;
    dotStr += result;
}

void writeFile(std::string filename, std::string content) {
    std::ofstream file(filename);

    if (file.is_open()) file << content;
    else {

        errs() << "  error opening file for writing!";
        errs() << "\n";
    }

}

PreservedAnalyses CFGPrinterBCPass::run(Function &F, FunctionAnalysisManager &FAM) {
    printFunctionName(F);
    int counter = 1;
    
    for(BasicBlock &BB : F) {
        BB.setName("BB" + std::to_string(BBcounter));
        BBcounter++;
        for (Instruction &I : BB) {
            if (!I.hasName() && !I.getType()->isVoidTy()) {
                I.setName(std::to_string(counter));
                counter++;
            }
        }
    }

    for (BasicBlock &BB : F) {
        printBasicBlock(BB);
        for (BasicBlock *BBSucc : successors(&BB)) {
            std::string res = BB.getName().str() + " -> " + BBSucc->getName().str() + '\n';
            //OS << res;
            dotStr += res;
        }
    }

    //OS << "}\n";
    dotStr += "}\n";

    writeFile(F.getName().str() + ".dot", dotStr);

    return PreservedAnalyses::all();
}
} // namespace cfgprinterbc

int main(int Argc, char **Argv) {
    // Hide all options apart from the ones specific to this tool.
    cl::HideUnrelatedOptions(CFGPrinterBCCategory);

    // Parse the command-line options that should be passed to the invariant
    // pass.
    cl::ParseCommandLineOptions(Argc, Argv,
                            "generate dot representation for CFG's\n");

    // Makes sure llvm_shutdown() is called (which cleans up LLVM objects)
    // http://llvm.org/docs/ProgrammersManual.html#ending-execution-with-llvm-shutdown
    llvm_shutdown_obj SDO;

    // Parse the IR file passed on the command line.
    SMDiagnostic Err;
    LLVMContext Ctx;
    std::unique_ptr<Module> M = parseIRFile(InputModule.getValue(), Err, Ctx);

    if (!M) {
        errs() << "Error reading bitcode file: " << InputModule << "\n";
        Err.print(Argv[0], errs());
        return -1;
    }

    // Create a FunctionPassManager and add the AddConstPass to it:
    FunctionPassManager FPM;
    FPM.addPass(cfgprinterbc::CFGPrinterBCPass(errs()));

    FunctionAnalysisManager FAM;
    // Register the module analyses:
    PassBuilder PB;
    PB.registerFunctionAnalyses(FAM);
    // Finally, run the passes registered with FPM.
    for (Function &F : *M) {
        FPM.run(F, FAM);
    }

    return 0;
}

