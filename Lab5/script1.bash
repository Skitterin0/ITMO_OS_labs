#!/bin/bash

./mem & pid0=$!
echo > values.log

while true; do
    line=$(top -p $pid0 -b -n 1 | head -8 | tail -n +8)
    free_mem=$(top -o %MEM -b -n 1 | head -4 | tail -n +4 | awk '{print ""$6""}')
    used_mem=$(top -o %MEM -b -n 1 | head -4 | tail -n +4 | awk '{print ""$8""}')
    free_swap=$(top -o %MEM -b -n 1 | head -5 | tail -n +5 | awk '{print ""$5""}')
    used_swap=$(top -o %MEM -b -n 1 | head -5 | tail -n +5 | awk '{print ""$7""}')
    avail_mem=$(top -o %MEM -b -n 1 | head -5 | tail -n +5 | awk '{print ""$9""}')
    line=$(echo -e $line | awk '{print ""$11" "$5" "$6" "$7" "$9""}')
    line=$(echo -e "$line $free_mem $used_mem $free_swap $used_swap $avail_mem\n")
    echo $line >> values.log
    sleep 1
done