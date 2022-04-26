#!/bin/sh

cd benchmarks

for d in */ ; do
    bench=${d%?}
    echo $bench

    cd $bench
    
    mkdir dot
    cd dot
    ./../../../build/bin/CFGPrinterBC ../IR/${bench}.bc

    cd ../..

done
