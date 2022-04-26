#!/bin/sh

cd benchmarks

for d in */ ; do
    bench=${d%?}
    echo $bench

    cd 
    mkdir src
    mv ${bench}.c src/${bench}.c

done
