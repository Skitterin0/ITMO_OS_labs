#!/bin/bash

a=()
count=0
> ./report.log

while true
do
    count=$((count+1))
    a+=(1 2 3 4 5 6 7 8 9 10)
    if [[ $(( count % 10000 )) -eq 0 ]]
    then
        echo "$(($count * 10))" >> ./report.log
    fi
done