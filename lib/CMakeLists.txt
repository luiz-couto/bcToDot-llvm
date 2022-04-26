#===============================================================================
# See: https://llvm.org/docs/CMake.html#developing-llvm-passes-out-of-source
#===============================================================================
add_executable(CFGPrinterBC
    CFGPrinterBC.cpp
    CFGPrinterBCPlugin.cpp)

target_link_libraries(CFGPrinterBC
    LLVMPasses
    LLVMCore
    LLVMIRReader
    LLVMSupport
)

target_include_directories(CFGPrinterBC PRIVATE
    "${CMAKE_CURRENT_SOURCE_DIR}/../include")