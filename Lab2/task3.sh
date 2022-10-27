#!/bin/bash

ps --no-headers -ax | sort -k 4 | tail -n 1 | awk '{print $1}'