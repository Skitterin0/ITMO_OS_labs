#!/bin/bash

./loop &
pid1=$!
renice -n 19 -p $pid1 

./loop &
./loop &
pid2=$!

sleep 10 && kill $pid2 &