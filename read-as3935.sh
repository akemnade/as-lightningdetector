#!/bin/bash
#  read-as3935.sh - bash script for reading the as3935 thunderstorm sensor
#  Copyright (c) 2014 Andreas Kemnade
#  This program is free software; you can redistribute it and/or modify
#  it under the terms of the GNU General Public License version 2 as
#  published by the Free Software Foundation.
#
#  This program is distributed in the hope that it will be useful,
#  but WITHOUT ANY WARRANTY; without even the implied warranty of
#  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
#  GNU General Public License for more details.
#
#  You should have received a copy of the GNU General Public License
#  along with this program; if not, write to the Free Software
#  Foundation, Inc., 675 Mass Ave, Cambridge, MA 02139, USA.


MYBUS=${MYBUS:-8}
MODE=${MODE:-outdoor}
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
