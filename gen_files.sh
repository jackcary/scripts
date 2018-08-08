#!/bin/bash

# create a directory and empty markdown file for every day from 0001/01/01 to 2018/12/31
# full path and filename will have the format  yyyy/mm/dd/yyyymmdd.md
# all months will have 31 days/files

for i in $(seq -f "%04g" 1 2018)
do
    for j in $(seq -f "%02g" 1 12)
    do
        for k in $(seq -f "%02g" 1 31)
        do
            echo $i/$j/$k >> dirs.txt
            echo $i/$j/$k/$i$j$k.md >> files.txt
        done
    done
done

# create directories and files
xargs mkdir -p < dirs.txt
xargs touch < files.txt

# clean up
rm dirs.txt
rm files.txt
