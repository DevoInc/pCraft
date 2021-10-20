#!/bin/bash
TMP=$(mktemp)
ls ../available | cut -f1 > $TMP

while read line
do
    ln -s ../available/$line . 
done < $TMP
