#!/bin/bash

FILE=$1

CONT=`cat $FILE | wc -l`

for LINE in `seq $CONT`; do 
IP=`cat $FILE | head -$LINE  | tail -1 | awk -F\; '{print $1}'`
PORTA=`cat $FILE | head -$LINE  | tail -1 | awk -F\; '{print $2}'`

telnet_port.sh $IP $PORT

sleep 1

done


