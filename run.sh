#!/bin/sh

cd benchmarks

for d in */ ; do
    bench=${d%?}
    
    cd $bench
    cd dot
    
    for FILE in * ; do
        echo ${FILE}
        dot -Tpdf ${FILE} -o ${FILE}.pdf
        mv ${FILE}.pdf ../pdf/${FILE}.pdf
    done

    cd ../..

done
