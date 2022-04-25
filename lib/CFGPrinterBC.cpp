#include "CFGPrinterBC.hpp"
#include "llvm/Passes/PassBuilder.h"
#include "llvm/Support/raw_ostream.h"

using namespace llvm;

namespace cfgprinterbc {

void CFGPrinterBCPass::printFunctionName(Function &F) {
    OS << "digraph CFG for " << "'" << F.getName().str() << "'" << " function {" << '\n';
}

PreservedAnalyses CFGPrinterBCPass::run(Function &F, FunctionAnalysisManager &FAM) {
    // get Function name
    printFunctionName(F);
    
    for(BasicBlock &BB : F) {
        // printBasicBlockHeader();
        BB.setName("BB" + BBcounter);
        for (Instruction &I : BB) {
            OS << I << '\n';
        }
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