#!/bin/bash

for pid in $(ps --no-headers -ax | awk '{print $1}')
do
        res=$(cat /proc/$pid/status 2>/dev/null | grep "VmRSS:" | awk '{print $2}')
        if [ -n "res" ]; then
                echo "$pid $res"
        fi
done | sort -n -k 2 | tail -n 1 | awk '{print "Proccess from search is " $1 ", reserved " $2 " kB"}'

top -o RES | head -n 8 | tail -n 1 | awk '{print "Process form top is " $2 ", reserved " $7 " kB"}'