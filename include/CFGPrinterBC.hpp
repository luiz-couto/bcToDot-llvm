#ifndef CFG_PRINTER_BC_H
#define CFG_PRINTER_BC_H

#include "llvm/IR/PassManager.h"
#include <map>


namespace cfgprinterbc {

/// A pass that prints bytecode programs into the dot format
struct CFGPrinterBCPass : public llvm::PassInfoMixin<CFGPrinterBCPass> {
    explicit CFGPrinterBCPass(llvm::raw_ostream &OS) : OS(OS) { BBcounter = 0; dotStr = ""; }
    /// Gets the result of AddConstAnalysis for the function \p F and uses it
    /// to replace the uses of the collected add instructions by their final
    /// value.
    ///
    /// \returns set of preserved analyses (all of them, except for
    /// AddConstAnalysis).
    llvm::PreservedAnalyses run(llvm::Function &F,
                                llvm::FunctionAnalysisManager &FAM);


    void printFunctionName(llvm::Function &F);
    void printBasicBlock(llvm::BasicBlock &BB, std::map<std::string, int> labelMap);
    void printInstruction(llvm::Instruction &I);

    private:
        llvm::raw_ostream &OS;
        int BBcounter;
        std::string dotStr;
};

} // namespace cfgprinterbc


#endif