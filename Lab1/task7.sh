#!/bin/bash

grep -E -s -o -h "[[:alnum:]+\.]+@+[[:alnum:]]+(\.[[:alnum:]])+" /etc/* |
awk -e '{print($1, "\n")}' > emails.lst