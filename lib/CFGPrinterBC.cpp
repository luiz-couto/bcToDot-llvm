#include "CFGPrinterBC.hpp"
#include "llvm/Support/raw_ostream.h"

using namespace llvm;

namespace cfgprinterbc {

PreservedAnalyses CFGPrinterBCPass::run(Function &F, FunctionAnalysisManager &FAM) {
    for(BasicBlock &BB : F) {
        for (Instruction &I : BB) {
            errs() << I << '\n';
        }
    }

    return PreservedAnalyses::all();
}


} // namespace cfgprinterbc