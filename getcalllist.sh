#!/bin/bash
#################################################
#  Get Last Heard List from MMDVMHost Log	#
#						#
#						#
#  VE3RD 			2020-05-03	#
#################################################
set -o errexit
set -o pipefail
sudo mount -o remount,rw /

call="$1"
tLine=$(sudo sed -n "/$call/p" /home/pi-star/SmartPhone/user.csv  | head -1)

city=$(echo "$tLine" | cut -d',' -f5)
prov=$(echo "$tLine" | cut -d',' -f6)
cntry=$(echo "$tLine" | cut -d',' -f7)
fname=$(echo "$tLine" | cut -d',' -f3)
lname=$(echo "$tLine" | cut -d',' -f4)
did=$(echo "$tLine" | cut -d',' -f1)
name="$fname $lname" 
#echo "$cntry"

printf "$call $name ID:$did,\n$city, $prov, $cntry\n"




