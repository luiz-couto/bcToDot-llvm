#include "CFGPrinterBC.hpp"
#include "llvm/Passes/PassBuilder.h"
#include "llvm/Support/raw_ostream.h"

using namespace llvm;

namespace cfgprinterbc {

void CFGPrinterBCPass::printFunctionName(Function &F) {
    OS << "digraph CFG for " << "'" << F.getName().str() << "'" << " function {" << '\n';
}

void CFGPrinterBCPass::printBasicBlock(BasicBlock &BB) {
    OS << BB.getName().str() << " [shape=record, label=\"{" << BB.getName().str() << ":\\l\\l\n";
    for (Instruction &I : BB) {
        OS << I << '\n';
    }
    OS << "}\"];\n";
}

PreservedAnalyses CFGPrinterBCPass::run(Function &F, FunctionAnalysisManager &FAM) {
    // get Function name
    printFunctionName(F);
    
    for(BasicBlock &BB : F) {
        BB.setName("BB" + std::to_string(BBcounter));
        printBasicBlock(BB);
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