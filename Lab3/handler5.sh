#!/bin/bash

result=1
operation="+"

(tail -f pipe) |
while true
do
    read LINE

    if [[ $LINE == "QUIT" ]]; then
        echo "Stopping script work"
        killall tail
        killall generator5
        exit 0
    elif [[ $LINE =~ "+"|"*" ]]; then
        operation=$LINE
        echo "new operation: $operation"  
    elif [[ $LINE =~ "-"?[[:digit:]]+ ]]; then
        if [[ $operation == "+" ]]; then
                result=$(($result+$LINE))
                echo "summ: $result"
            else
                result=$(($result*$LINE))
                echo "mult: $result"
            fi
    else
        echo "ERROR: wrong input"
        killall tail
        killall generator5
        exit 1
    fi
done