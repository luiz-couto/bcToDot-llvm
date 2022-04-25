#===============================================================================
# See: https://llvm.org/docs/CMake.html#developing-llvm-passes-out-of-source
#===============================================================================
add_library(CFGPrinterBC MODULE
    CFGPrinterBC.cpp
    CFGPrinterBCPlugin.cpp)

target_include_directories(CFGPrinterBC PRIVATE
    "${CMAKE_CURRENT_SOURCE_DIR}/../include")