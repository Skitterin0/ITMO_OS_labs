#!/bin/bash

crontab -l > current

echo "5 * * * * /home/user/lab3/task1" >> current

crontab current
rm current