#!/bin/sh

cd benchmarks

for d in */ ; do
    bench=${d%?}
    echo $bench

    cd $bench
    
    cd IR
    llvm-as ${bench}.ll -o ${bench}.bc

    cd ../..

done
