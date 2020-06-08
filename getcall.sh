#!/bin/bash
#################################################
#  Get Call Info from MMDVMHost Log		#
#						#
#						#
#  VE3RD 			2020-05-03	#
#################################################
set -o errexit
set -o pipefail

if [ -z "$1" ]; then
	exit
fi


call="$1"
# m8=$(sed -nr "/^\[Profile $pnum\]/ { :l /^Address[ ]*=/ { s/.*=[ ]*//; p; q;}; n; b l;}" $fromfile)
# m8=$(sed -nr "/^\[Profile $pnum\]/ { :l /^Address[ ]*=/ { s/.*=[ ]*//; p; q;}; n; b l;}" $fromfile)
#TOList=$(echo "$MList2" | tail -1 | awk '{print substr($2,6,5),substr($3,0,6),$11,$13}')
# voice header from K4WZV to TG 31665

f1=$(ls -tr /var/log/pi-star/MMDVM* | tail -1)
#MList=$(sudo sed -n '/"$call"/p' $f1 | sed 's/,//g' | sort -k2,3 | tail -2)
MList=$(sudo sed -n "/header from $call/p" $f1 | sed 's/,//g' | tail -20) 
#echo "$MList"

line1=$(echo "$MList" |  awk '{print substr($2,6,5),substr($3,0,6),$12,$15}')

#line1=$(echo "$MList" | awk '{printf "%s %s %s %s\n", $2 $3 $12 $15}')

echo "$line1"



