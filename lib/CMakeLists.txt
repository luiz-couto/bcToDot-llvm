#===============================================================================
# See: https://llvm.org/docs/CMake.html#developing-llvm-passes-out-of-source
#===============================================================================
add_library(CFGPrinter MODULE
    CFGPrinter.cpp)

target_include_directories(CFGPrinter PRIVATE
    "${CMAKE_CURRENT_SOURCE_DIR}/../include")