#include "CFGPrinterBC.hpp"
#include "llvm/Passes/PassBuilder.h"
#include "llvm/Support/raw_ostream.h"
#include <map>

using namespace llvm;

namespace cfgprinterbc {

// std::string genOpStr(Value *operand) {
//     if (isa<Function>(operand)) return "@" + operand->getName().str();

//     if (isa<BasicBlock>(operand)) return operand->getName().str();

//     if (ConstantInt *CI = dyn_cast<ConstantInt>(operand)) return std::to_string(CI->getZExtValue());

//     if (ConstantExpr *CE = dyn_cast<ConstantExpr>(operand)){
//         std::string rep = " (";
//         for (int j=0; j < CE->getNumOperands(); j++) {
//             rep += genOpStr(CE->getOperand(j));
//         }
//         return rep + ")";
//     }

//     if (operand->hasName()) return "%" + operand->getName().str();

//     return "";
// }

void CFGPrinterBCPass::printFunctionName(Function &F) {
    OS << "digraph CFG for " << "'" << F.getName().str() << "'" << " function {" << '\n';
}

void CFGPrinterBCPass::printBasicBlock(BasicBlock &BB, std::map<std::string, int> labelMap) {
    OS << BB.getName().str() << " [shape=record, label=\"{" << BB.getName().str() << ":\\l\\l\n";
    int counter = 0;
    for (Instruction &I : BB) {
        if (!I.getType()->isVoidTy()) {
            if (!I.hasName()) {
                I.setName(std::to_string(counter));
                counter++;
                continue;
            }

            std::string iName = I.getName().str();
            if (labelMap.find(iName) != labelMap.end()) {
                I.setName(iName + "." + std::to_string(labelMap[iName]));
                labelMap[iName] += 1;
            } else {
                I.setName(iName + ".0");
                labelMap[iName] = 1;
            }
        }
    }

    for (Instruction &I : BB) {
        printInstruction(I);
    }
    OS << "}\"];\n";
}

void CFGPrinterBCPass::printInstruction(Instruction &I) {
    std::string res = "";
    
    // if (!I.getType()->isVoidTy()){
    //     res += "%" + I.getName().str() + " = ";
    // }

    res += I.getName().str() + " = ";

    res += I.getOpcodeName();

    // if (PHINode *PN = dyn_cast<PHINode>(&I)) {
    //     for (int i = 0; i < PN->getNumIncomingValues(); i++) {
    //         res += std::string(i ? ", " : "") + " [ " + genOpStr(PN->getIncomingValue(i)) + ", " + genOpStr(PN->getIncomingBlock(i)) + " ]";
    //     }
    // } else {
    //     for(Use &operand : I.operands()) {
    //         res += " " + genOpStr(operand.get());
    //     }
    // }

    // res += "\\l";
    OS << res << "\n";
    //OS << I << "\n";

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

    return PreservedAnalyses::all();
}


} // namespace cfgprinterbc