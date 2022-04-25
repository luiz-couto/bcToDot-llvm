#include "CFGPrinterBC.hpp"
#include "llvm/Support/raw_ostream.h"

using namespace llvm;

namespace cfgprinterbc {

PreservedAnalyses CFGPrinterBCPass::run(Function &F, FunctionAnalysisManager &FAM) {
    
    // get Function name
    OS << F.getName().str() << '\n';
    
    for(BasicBlock &BB : F) {
        BB.printAsOperand(OS, false);
        for (Instruction &I : BB) {
            OS << I << '\n';
        }
    }

    return PreservedAnalyses::all();
}


} // namespace cfgprinterbc