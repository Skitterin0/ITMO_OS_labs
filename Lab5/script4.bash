#!/bin/bash

K=$1
N=$2

for (( i=0; i < K; i++ )); do
    ./newmem $N &
    sleep 1
done