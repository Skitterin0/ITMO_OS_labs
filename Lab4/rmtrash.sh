#!/bin/bash

if [[ $# != 1 ]]
then
    echo "Just one argument, silly"
    exit 1
fi

if [[ ! -f $1 ]]
then
    echo "No such file, silly"
    exit 1
fi

[ -d ~/.trash ] || mkdir ~/.trash


name=$1\(`date +%d-%m-%Y_%T`\)

ln $PWD/$1 ~/.trash/$name

rm $PWD/$1

echo "path: $PWD/$1 name: $name" >> ~/.trash.log