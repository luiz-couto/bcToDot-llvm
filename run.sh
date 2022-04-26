#!/bin/sh

cd benchmarks

for d in */ ; do
    bench=${d%?}
    echo $bench

    cd $bench
    
    mkdir src
    mv ${bench}.c src/${bench}.c

    mkdir IR
    mv ${bench}.ll IR/${bench}.ll
    

    cd ..

done
