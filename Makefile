all: env
	cmake --build build/

env:
	cmake -DCMAKE_EXPORT_COMPILE_COMMANDS=1 -DLLVM_INSTALL_DIR=${LLVM_INSTALL_DIR} -G "Unix Makefiles" -B build/
	if [ -f "./compile_commands.json" ]; then rm -rf ./compile_commands.json; fi
	ln ./build/compile_commands.json .

clean:
	rm -rf build compile_commands.json