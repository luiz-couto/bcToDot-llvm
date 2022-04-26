#!/bin/sh

cd benchmarks

for d in */ ; do
    bench=${d%?}
    echo $bench

    cd $bench
    mkdir IR
    mv ${bench}.ll src/${bench}.ll
    cd ..

done
