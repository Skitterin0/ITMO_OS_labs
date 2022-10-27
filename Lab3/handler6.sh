#!/bin/bash

echo $$ > .pid

result=1
MODE=""

usr1()
{
    MODE="+"
}

usr2()
{
    MODE="*"
}

term()
{
    MODE="TERM"
}

trap 'usr1' USR1
trap 'usr2' USR2
trap 'term' SIGTERM

while true
do
    case $MODE in
        "+")
            result=$(($result+2))
            echo "summ: $result"
            ;;

        "*")
            result=$(($result*2))
            echo "mult: $result"
            ;;

        "TERM")
            echo "Finished by other process signal"
            exit 0
            ;;
    esac
    sleep 1
done