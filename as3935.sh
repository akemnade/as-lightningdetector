#!/bin/bash
MYBUS=8
MODE=outdoor
function as3835init {
  i2cset -y $MYBUS $1 0x3c 0x96
  sleep 0.5
  i2cset -y $MYBUS $1 8 $2
  sleep 0.5
  i2cset -y $MYBUS $1 0x3D 0x96
  sleep 0.5
  i2cset -y $MYBUS $1 8 $[$2+64]
  sleep 0.5
  i2cset -y $MYBUS $1 8 $2
  if [ $MODE = outdoor ]; then
    i2cset -y $MYBUS $1 0 0x1c
  else
    i2cset -y $MYBUS $1 0 0x24
  fi 
}

function as3835dist {
  i2cget -y $MYBUS $1 7
}

#as3835init 0 11
as3835init 3 0
while true
do
INT3="$(i2cget -y $MYBUS 3 3)"
#INT0="$(i2cget -y $MYBUS 0 3)"
#DIST0="$(as3835dist 0)"
DIST3="$(as3835dist 3)" 
echo "$(date) 3: $INT3 $DIST3"
sleep 1
done
