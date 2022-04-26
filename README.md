# bcToDot-llvm

### Group
Luiz Felipe Couto Gontijo - 2018054524

## Description
A LLVM pass that prints bytecode programs into the dot format. This is the first project assignement of the Static Analysis course at UFMG.
It has the follow properties:
- Each instruction is printed with an opcode.
- All the arguments of an instruction are printed next to this instruction.
- Arguments that do not have names, such as getelementptr in function calls, are not printed.
- Type information is not printed.

## How To Run It
This pass runs outside of LLVM tree.

1. From the same director of this file, run to compile:
    
    ```bash
    make LLVM_INSTALL_DIR=<path/to/llvm-project/build/folder>
    ```

LLVM_INSTALL_DIR is the directory containing llvm build files.
`e.g. llvm-project/build/`

2. To run the LLVM pass:
From the same director of this file, run:

    ```bash
    ./build/bin/CFGPrinterBC <bytecode_file>
    ```

## Stanford benchmarks:
The generated PDF files containing the generated CFGs are in the directory `benchmarks/<bench>/pdf`
Where `bench` is the name of the benchmark, like `Bubblesort`. All the src and Intermediate LLVM files used are also on the bench folder.