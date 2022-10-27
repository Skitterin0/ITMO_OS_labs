#!/bin/bash

IFS=$'\n'
echo "" > start.o

for var in $(ps --no-headers -ef | awk '{print $2 " " $8}')
do
        pid=$(echo $var | awk '{print $1}')
        path=$(echo $var | awk '{print $2}')
        mem=$(cat /proc/$pid/io 2>/dev/null |
              grep "read_bytes:" | awk '{print $2}')
        echo "$pid $path $mem" >> start.o
done

sleep 60

for var in $(ps --no-headers -ef | awk '{print $2 " " $8}')
do
        pid=$(echo $var | awk '{print $1}')
        path=$(echo $var | awk '{print $2}')
        mem=$(cat /proc/$pid/io 2>/dev/null |
              grep "read_bytes:" | awk '{print $2}')
        prevMem=$(cat start.o | awk -v prevPid=$pid '{if ($1 == prevPid) print $3}')
        if [[ $prevMem == "" ]]; then
                continue
        fi
        res=$(echo "$mem - $prevMem" | bc)
        echo "$pid:$path:$res"
done | sort -n -k 3 | tail -n 3

rm start.o