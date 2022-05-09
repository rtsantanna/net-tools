#!/bin/bash
# Program name: pingall.sh
date
cat $1 |  while read output
do
    ping -c 1 -i 1  -W 1 -q "$output" > /dev/null
    #fping -c 1 -t 5 -i 5 -q  "$output" > /dev/null
    if [ $? -eq 0 ]; then
    echo "node $output is up" 
    else
    echo "node $output is down"
    fi
done

