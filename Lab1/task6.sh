#!/bin/bash

awk '$3 == "(WW)" {print}' /var/log/anaconda/X.log | sed 's/(WW)/Warning:/' > full.log
awk '$3 == "(II)" {print}' /var/log/anaconda/X.log | sed 's/(II)/Information:/' >> full.log
less full.log