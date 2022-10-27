#!/bin/bash

for pid in $(ps --no-headers -ef | awk '{print $2}')
do
        ppid=$(cat /proc/$pid/status 2>/dev/null |
               grep "PPid:" | awk '{print $2}')
        art=$(cat /proc/$pid/sched 2>/dev/null |
               awk '{if ($1 == "se.sum_exec_runtime") sum=$3
                     if ($1 == "nr_switches") nr=$3
                     if (-n sum && -n nr && nr!=0) {print sum/nr; nr=0}}')
        if [[ -n $ppid && -n $art ]]; then
                echo "$pid $ppid $art"
        fi
done | sort -n -k 2 | awk '{print "ProcessID="$1" : Parent_ProcessID="$2" : Average_Running_Time="$3""}' > task4.log