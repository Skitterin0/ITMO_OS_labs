#!/bin/bash

IFS=$'\n'
echo "" > task5.log

count=0
avgTime=0
ppid=$(cat task4.log | head -n 1 | awk '{print $3}')

for str in $(cat task4.log)
do
        currPpid=$(echo "$str" | awk '{print $3}')
        currTime=$(echo "$str" | awk -F= '{print $4}')

        if [[ "$currPpid" == "$ppid" ]]; then
                count=$(($count+1))
                avgTime=$(echo "scale=5; $avgTime+$currTime" | bc)
        else
                print1=$(echo "$ppid" | awk -F= '{print $2}')
                print2=$(echo "scale=5; $avgTime/$count" | bc)
                echo "Average_Running_Children_of_ParentID=$print1 is $print2" >> task5.log

                ppid=$currPpid
                count=1
                avgTime=$currTime
        fi
        echo "$str" >> task5.log
done

print1=$(echo "$ppid" | awk -F= '{print $2}')
print2=$(echo "scale=5; $avgTime/$count" | bc)
echo "Average_Running_Children_of_ParentID=$print1 is $print2" >> task5.log