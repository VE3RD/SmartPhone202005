#!/bin/bash
#################################################
#  Get Last Heard Liost from MMDVMHost Log	#
#						#
#						#
#  VE3RD 			2020-05-03	#
#################################################
set -o errexit
set -o pipefail
sudo mount -o remount,rw /

if [ -f /home/pi-star/lh2_start.txt ]; then
  rm /home/pi-star/lh2_start.txt
fi
if [ -f /home/pi-star/lhlog.txt ]; then
  rm /home/pi-star/lhlog.txt
fi

echo "Args = $@" >> /home/pi-star/lh2_start.txt

name=""

declare -i n
####################################################
function domode2
{
line3=""
while read -r line
do
	call=$(echo "$line" | cut -d' ' -f3)
	tm=$(echo "$line" | cut -d' ' -f2)
	pl=$(echo "$line" | cut -d' ' -f5)

	echo "Add Call: $call" >> /home/pi-star/lh2_start.txt
	name=$(sudo sed -n "/$call/p" /usr/local/etc/DMRIds.dat | sed -E "s/[[:space:]]+/|/g" | cut -d'|' -f3 | head -1)
	did=$(sudo sed -n "/$call/p" /usr/local/etc/DMRIds.dat | sed -E "s/[[:space:]]+/|/g" | head -1 | cut -d'|' -f1)
	

	line2=$(echo "$line $name $did" | awk '{printf  "%5s %.5s %6s %7s %6s %6s\n",$1,$2,$3,$6,$4,$7,"   "}')
#	echo "  $line2"
	line3=${line2:0:37}
	list4+="$line3"
done <<< "$list9"
var="${list4:0:240}"
echo "${var}"
echo "${var}" >> ./lh2_start.txt
#echo "$list3"
}
######################################

ber3=""

f1=$(ls -tr /var/log/pi-star/MMDVM* | tail -1)
Last=$(tail -1 $f1)
#echo "$Last"

if [[ "$Last" == *"RF end"* ]]; then
  	list1a=$(echo "$Last" | sed 's/,//g')
#	echo "$list1a"
	call3=$(echo "$list1a" | awk '{print $14}')
	ber3=$(echo "$list1a" | awk '{print $21}')
	rssi3=$(echo "$list1a" | awk '{print $23}')
fi

#sudo sed -n '/RF/p' $f1 | sed 's/,//g' | tail -1
#echo "File: $f1"
list1=$(sudo sed -n '/received network voice header from/p' $f1 | sed 's/,//g' | sort -k2,3 | tail -1)
list3=$(echo "$list1" | awk '{print substr($2,6,5),substr($3,0,6),$12,$15}')

#list1a=$(printf %s\n "tail -1 $f1 | grep 'RF end' | sed 's/,//g'")
list1b=$(sudo sed -n '/RF end/p' $f1 | sed 's/,//g' | tail -1)

#echo "$list1"
list2=$(sudo sed -n '/received network end of voice transmission from/p' $f1 | sed 's/,//g' | sort -k2,3 | tail -1)
#echo "$list2"
list3=$(echo "$list1" | awk '{print substr($2,6,5),substr($3,0,6),$12,$15}')

list4=$(echo "$list2" | awk '{print substr($2,6,5),substr($3,0,6),$14,$6,$17,$18,$20}')
list3a=$(echo "$list1a" | awk '{print $12,$15}')
#echo "$list3"
#echo "$list4"


call1=$(echo "$list3" | awk '{print $3}')
call2=$(echo "$list4" | awk '{print $3}')
#echo "Calls $call1 -- $call2"
call="$call1"

	name=$(sudo sed -n "/$call1/p" /usr/local/etc/DMRIds.dat | sed -E "s/[[:space:]]+/|/g" | cut -d'|' -f3 | head -1)
	did=$(sudo sed -n "/$call1/p" /usr/local/etc/DMRIds.dat | sed -E "s/[[:space:]]+/|/g" | head -1 | cut -d'|' -f1)
        DT=$(echo "$list4" | awk '{print $1}')
	TM=$(echo "$list4" | awk '{print $2}')

	TG=$(echo "$list4" | awk '{print $5}')
        TS=$(echo "$list4" | awk '{print $4}')
        Sec=$(echo "$list4" | awk '{print $6}')
        PLoss=$(echo "$list4" | awk '{print $7}')


if [ "$1" == "2" ]; then
        printf "3\n%s %s %s %s \nID:%s TG:%s TS:%s \nDur:%s PLoss:%s \n" "$DT" "$TM" "$call" "$name" "$did" "$TG" "$TS" "$Sec" "$PLoss"
#        printf "3\n$DT $TM $call $name ID:$did TG:$TG"

else
	if [ "$call1" == "$call2" ]; then
		if [ -z "$ber3" ]; then
			printf "2\n%s %s \nID:%s TG:%s TS:%s Dur:%s PLoss:%s\n%s\n" "$call" "$name" "$did" "$TG" "$TS" "$Sec" "$PLoss" "$TG"
		else
			printf "3\n%s  BER:%s  RSSI:%s\n", "$call3" "ber3" "rssi3"
			ber3=""
		fi
	else
		tg1=$(echo "$list3" | awk '{print $4}')
		printf "1\n%s %s\nID:%s TG:%s\n" "$call" "$name" "$did" "$tg1"
	fi
fi

#echo ""

