#!/bin/bash

if [[ $# != 1 ]]
then
    echo "Just one argument, silly"
    exit 1
fi

if [[ $1 == *"/"* ]]
then
    echo "No paths, silly"
    exit 1
fi

tDir=~/.trash

[ -d $tDir ] || {
    echo "Directory for trash doesn't exist, silly"
    exit 1
}

trashFiles=$(ls -A $tDir | wc -l)

[[ $trashFiles == 0 ]] && {
    echo "Nothing to restore, silly"
    exit 1
}

tlog=~/.trash.log

[ -s $tlog ] || {
    echo "Log file doesn't exists or is empty, silly"
    exit 1
}

IFS=$'\n'
fileCount=0

for str in $(cat $tlog)
do
    filePath=$(echo $str | awk '{print $2}')

    if [ "$1" = "${filePath##*/}" ]
    then
        
        fileCount=$(($fileCount+1))
        dir=${filePath%/*}
        tName=$(echo $str | awk '{print $4}')


        echo -en "Fullpath: $filePath \nDo you want to restore this file? (y/n) "
        read ans

        case $ans in
        Y | y)
            if [ -d $dir ]
            then
                dirFile=$filePath
                while [ -f $dirFile ]
                do
                    echo -en "File with this name already exists\nGive it another name: "
                    read name
                    dirFile=$dir/$name
                done

                ln $tDir/$tName $dirFile
            else
                echo "Directory doesn't exists. File will be moved to the home directory"
                dirFile=~/$1
                while [ -f $dirFile ]
                do
                    echo -en "File with this name already exists\nGive it another name: "
                    read name
                    dirFile=~/$name
                done

                ln $tDir/$tName $dirFile
            fi

            grep -Fv "name: $tName" $tlog > tmpFile
            mv tmpFile $tlog
            rm $tDir/$tName

            ;;

        N | n)
            ;;

        *)

            echo "I SAID Y OR N YOU IDIOT"
            exit 1
            ;;
        esac
    fi
done

[[ $fileCount == 0 ]] && {
    echo "No such file to untrash, silly"
    exit 1
}

exit 0