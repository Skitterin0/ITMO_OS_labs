#!/bin/bash

ps --no-headers -ax | grep "/sbin/" | awk '{print $1}' > task2.log