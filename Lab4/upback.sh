#!/bin/bash

prevBack=$(ls ~ | grep -E "Backup-[[:digit:]]{4}-[[:digit:]]{2}-[[:digit:]]{2}" | sort -n -r | head -n 1)

[ -z $prevBack ] && { 
    echo "Previous backup absent"
    exit 1
}

if [[ -d ~/restore ]]
then
    rm ~/restore/*
else
    mkdir ~/restore
fi

for var in $(ls ~/$prevBack | grep -Ev "\.[[:digit:]]{4}-[[:digit:]]{2}-[[:digit:]]{2}$")
do
    cp ~/$prevBack/$var ~/restore/
done