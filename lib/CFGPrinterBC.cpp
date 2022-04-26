#include "CFGPrinterBC.hpp"
#include "llvm/Passes/PassBuilder.h"
#include "llvm/Support/raw_ostream.h"
#include <map>

using namespace llvm;

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

    int counter = 0;
    for (Instruction &I : BB) {
        if (!I.getType()->isVoidTy()) {
            I.setName(std::to_string(counter));
        }
    }

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

        for (unsigned int i = 0; i < I.getNumOperands() - 1; i++) {
            result += genOpStr(I.getOperand(i));
                if (i < I.getNumOperands() - 2) {
                    result += ", ";
                }
        }

        result += ")\\l\n";
        //OS << result;
        dotStr += result;
        return;
    }

    for (int i = I.getNumOperands() - 1; i >= 0; i--) {
        result += " " + genOpStr(I.getOperand(i));
    }

    result += "\\l\n";
    //OS << result;
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
    
    for(BasicBlock &BB : F) {
        BB.setName("BB" + std::to_string(BBcounter));
        printBasicBlock(BB);
        BBcounter++;
    }

    for (BasicBlock &BB : F) {
        for (BasicBlock *BBSucc : successors(&BB)) {
            std::string res = BB.getName().str() + " -> " + BBSucc->getName().str() + '\n';
            //OS << res;
            dotStr += res;
        }
    }

    //OS << "}\n";
    dotStr += "}\n";

    writeFile("teste.dot", dotStr);

    return PreservedAnalyses::all();
}


} // namespace cfgprinterbc