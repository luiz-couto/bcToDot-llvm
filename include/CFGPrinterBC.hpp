#ifndef CFG_PRINTER_BC_H
#define CFG_PRINTER_BC_H

#include "llvm/IR/PassManager.h"


namespace cfgprinterbc {

/// A pass that prints bytecode programs into the dot format
struct CFGPrinterBCPass : public llvm::PassInfoMixin<CFGPrinterBCPass> {
    /// Gets the result of AddConstAnalysis for the function \p F and uses it
    /// to replace the uses of the collected add instructions by their final
    /// value.
    ///
    /// \returns set of preserved analyses (all of them, except for
    /// AddConstAnalysis).
    llvm::PreservedAnalyses run(llvm::Function &F,
                                llvm::FunctionAnalysisManager &FAM);
};

} // namespace cfgprinterbc


#endif