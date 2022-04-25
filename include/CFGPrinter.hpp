#ifndef CFG_PRINTER_H
#define CFG_PRINTER_H

#include "llvm/IR/PassManager.h"

using namespace llvm;

namespace cfgprinter {

/// A transformation pass that evaluates all constant-only add instructions
/// and replaces their uses by the computed constant.
struct CFGPrinterPass : public llvm::PassInfoMixin<CFGPrinterPass> {
    /// Gets the result of AddConstAnalysis for the function \p F and uses it
    /// to replace the uses of the collected add instructions by their final
    /// value.
    ///
    /// \returns set of preserved analyses (all of them, except for
    /// AddConstAnalysis).
    llvm::PreservedAnalyses run(llvm::Function &F,
                                llvm::FunctionAnalysisManager &FAM);
};

} // namespace cfgprinter


#endif