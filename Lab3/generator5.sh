#!/bin/bash

while true
do
    read LINE
    if [[ $LINE == "*" ]]
    then
        echo "*" > pipe
    else
        echo $LINE > pipe
    fi
done