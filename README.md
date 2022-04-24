# bcToDot-llvm
A LLVM pass that prints bytecode programs into the dot format. This is the first project assignement of the Static Analysis course at UFMG.
It has the follow properties:
- Each instruction is printed with an opcode.
- All the arguments of an instruction are printed next to this instruction.
- Arguments that do not have names, such as getelementptr in function calls, are not printed.
- Type information is not printed.
