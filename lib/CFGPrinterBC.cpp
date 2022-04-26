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
    OS << "digraph \"CFG for " << "'" << F.getName().str() << "'" << " function\" {" << '\n';
}

void CFGPrinterBCPass::printBasicBlock(BasicBlock &BB, std::map<std::string, int> labelMap) {
    OS << BB.getName().str() << " [shape=record, label=\"{" << BB.getName().str() << ":\\l\\l\n";
    int counter = 0;
    for (Instruction &I : BB) {
        if (!I.getType()->isVoidTy()) {
            I.setName(std::to_string(counter));
        }
    }

    for (Instruction &I : BB) {
        printInstruction(I);
    }
    OS << "}\"];\n";
}

void CFGPrinterBCPass::printInstruction(Instruction &I) {
    std::string result;

    if (!I.getType()->isVoidTy()) {
        result += "%" + I.getName().str() + " = ";
    }

    result += I.getOpcodeName();

    if (PHINode *PN = dyn_cast<PHINode>(&I)) {

        for (int i = 0; i < PN->getNumIncomingValues(); i++) {
            result += std::string(i ? ", " : "");
            result += " [" + genOpStr(PN->getIncomingValue(i));
            result += ", " + genOpStr(PN->getIncomingBlock(i)) + " ]";
        }

        OS << result << "\\l" << "\n";
        return;
    }
	
    if (I.getOpcode() == Instruction::Call) {
        result += " " + genOpStr(I.getOperand(I.getNumOperands() - 1));
        result += "(";

        for (int i = 0; i < I.getNumOperands() - 1; i++) {
            result += genOpStr(I.getOperand(i));
                if (i < I.getNumOperands() - 2) {
                    result += ", ";
                }
        }

        result += ")";
        OS << result << "\\l" << "\n";
        return;
    }

    for (int i = I.getNumOperands() - 1; i >= 0; i--) {
        result += " " + genOpStr(I.getOperand(i));
    }

    OS << result << "\\l" << "\n";
}

PreservedAnalyses CFGPrinterBCPass::run(Function &F, FunctionAnalysisManager &FAM) {
    // get Function name
    printFunctionName(F);
    std::map<std::string, int> labelMap;
    
    for(BasicBlock &BB : F) {
        BB.setName("BB" + std::to_string(BBcounter));
        printBasicBlock(BB, labelMap);
        BBcounter++;
    }

    for (BasicBlock &BB : F) {
        for (BasicBlock *BBSucc : successors(&BB)) {
            OS << BB.getName().str() << " -> " << BBSucc->getName().str() << '\n';
        }
    }

    OS << "}\n";

    return PreservedAnalyses::all();
}


} // namespace cfgprinterbc