#include "CFGPrinterBC.hpp"
#include "llvm/Passes/PassBuilder.h"
#include "llvm/Passes/PassPlugin.h"

using namespace llvm;


/// Takes the \p Name of a transformation pass and check if it is the name of
/// any of the passes implemented. If so, add it to the FunctionPassManager \p
/// FPM.
///
/// \returns true if \p Name corresponds to any of the passes implemented;
/// otherwise, returns false.
bool registerPipeline(StringRef Name, FunctionPassManager &FPM,
                      ArrayRef<PassBuilder::PipelineElement>) {

    if (Name == "cfgPrinterBC") {
        FPM.addPass(cfgprinterbc::CFGPrinterBCPass());
        return true;
    }

    return false;
}

PassPluginLibraryInfo getCFGPrinterBCPluginInfo() {
    return {LLVM_PLUGIN_API_VERSION, "CFGPrinterBC", LLVM_VERSION_STRING,
            [](PassBuilder &PB) {
                // 2: Register the AddConstPrinterPass as "print<add-const>" so
                // that it can be used when specifying pass pipelines with
                // "-passes=". Also register AddConstPass as "add-const".
                PB.registerPipelineParsingCallback(registerPipeline);
            }};
}

// The public entry point for a pass plugin:
extern "C" LLVM_ATTRIBUTE_WEAK PassPluginLibraryInfo llvmGetPassPluginInfo() {
    return getCFGPrinterBCPluginInfo();
}