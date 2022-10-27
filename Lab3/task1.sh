#!/bin/bash

curDate=`date +%d-%m-%Y_%T`

mkdir ~/test 2>/dev/null && { 
    echo "catalog test was created succesfully" > ~/report
    touch ~/test/$curDate
}

ping net_nikogo.ru 2>/dev/null || echo "$curDate ERROR: no server response" >> ~/report