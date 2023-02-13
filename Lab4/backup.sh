#!/bin/bash

dateFull=$(date +%F)
dateSec=$(date -d $dateFull "+%s")

prevBack=$(ls ~ | grep -E "Backup-[[:digit:]]{4}-[[:digit:]]{2}-[[:digit:]]{2}" | sort -n | tail -n 1)

datePrevBack=$(echo $prevBack | sed "s/Backup-//")

if [ -z $prevBack ]
then
    datePrevBackSec=0
else
    datePrevBackSec=$(date -d $datePrevBack +"%s")
fi

dateComparisonSec=$((dateSec - datePrevBackSec))
dateComparison=$((dateComparisonSec/3600/24))

[ -d ~/source ] || { 
    echo "Directory $HOME/source doesn't exist"
    exit 1
}

[ -f ~/backup-report ] || {
    echo "File $HOME/backup-report doesn't exist"
    exit 1 
}

if [[ $dateComparison -gt 7 || -z $prevBack ]]
then
    currentBack=~/Backup-$dateFull
    mkdir $currentBack
    cp -r ~/source/. $currentBack
    filesList=$(ls $currentBack)
    echo -e "new directory was created: Backup-$dateFull date: $dateFull;\nfiles : $filesList" >> ~/backup-report
else
    for var in $(ls ~/source)
    do
        if [[ -f ~/$prevBack/$var ]]
        then
            prevSize=$(wc -c ~/$prevBack/$var | awk '{print $1}')
            currentSize=$(wc -c ~/source/$var | awk '{print $1}')

            if [[ $prevSize != $currentSize ]]
            then
                newName=$var.$dateFull

                mv ~/$prevBack/$var ~/$prevBack/$newName
                cp ~/source/$var ~/$prevBack
                echo $newName $var >> changedFiles
            fi
        else
            cp ~/source/$var ~/$prevBack
            echo $var >> newFiles
        fi
    done
    echo "directory was updated: $prevBack date: $dateFull" >> ~/backup-report
    [ -s newFiles ] && { echo "new files: $(cat newFiles)" >> ~/backup-report; }
    [ -s changedFiles ] && { echo "changed files: $(cat changedFiles)" >> ~/backup-report; }
fi

rm newFiles changedFiles 2>/dev/null

exit 0