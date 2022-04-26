#ifndef CFG_PRINTER_BC_H
#define CFG_PRINTER_BC_H

#include "llvm/IR/PassManager.h"
#include <map>
#include <fstream>


namespace cfgprinterbc {

/// A pass that prints bytecode programs into the dot format
struct CFGPrinterBCPass : public llvm::PassInfoMixin<CFGPrinterBCPass> {
    explicit CFGPrinterBCPass(llvm::raw_ostream &OS) : OS(OS) { BBcounter = 0; dotStr = ""; }
    ///
    /// \returns set of preserved analyses (all of them, except for
    /// AddConstAnalysis).
    llvm::PreservedAnalyses run(llvm::Function &F,
                                llvm::FunctionAnalysisManager &FAM);


    void printFunctionName(llvm::Function &F);
    void printBasicBlock(llvm::BasicBlock &BB);
    void printInstruction(llvm::Instruction &I);

    private:
        llvm::raw_ostream &OS;
        int BBcounter;
        std::string dotStr;
};

} // namespace cfgprinterbc


#endif