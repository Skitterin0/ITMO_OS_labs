#!/bin/bash

ps --no-headers -u user | wc -l > task1.log
ps --no-headers -au user | awk '{print $1 " : " $4}' >> task1.log