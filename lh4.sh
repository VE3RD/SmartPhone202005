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
exit
#echo "$list3"
}
######################################


f1=$(ls -tr /var/log/pi-star/MMDVM* | tail -1)
#echo "File: $f1"
list1=$(sudo sed -n '/received network voice header from/p' $f1 | sed 's/,//g' | sort -k2,3 | tail -1)
#echo "$list1"
list2=$(sudo sed -n '/received network end of voice transmission from/p' $f1 | sed 's/,//g' | sort -k2,3 | tail -1)
#echo "$list2"
list3=$(echo "$list1" | awk '{print substr($2,6,5),substr($3,0,6),$12,$15}')
list4=$(echo "$list2" | awk '{print substr($2,6,5),substr($3,0,6),$14,$6,$17,$18,$20}')
#echo "$list3"
#echo "$list4"


call1=$(echo "$list3" | awk '{print $3}')
call2=$(echo "$list4" | awk '{print $3}')
#echo "Calls $call1 -- $call2"
call="$call1"

	name=$(sudo sed -n "/$call1/p" /usr/local/etc/DMRIds.dat | sed -E "s/[[:space:]]+/|/g" | cut -d'|' -f3 | head -1)
	did=$(sudo sed -n "/$call1/p" /usr/local/etc/DMRIds.dat | sed -E "s/[[:space:]]+/|/g" | head -1 | cut -d'|' -f1)

if [ "$1" == "2" ]; then
        DT=$(echo "$list4" | awk '{print $1}')
	TM=$(echo "$list4" | awk '{print $2}')

	TG=$(echo "$list4" | awk '{print $5}')
        TS=$(echo "$list4" | awk '{print $4}')
        Sec=$(echo "$list4" | awk '{print $6}')
        PLoss=$(echo "$list4" | awk '{print $7}')
        printf "%s %s %s %s %s  ID:%s \nTG:%s TS:%s Dur:%s PLoss:%s \n" "3" $DT $TM $call $name $did $TG $TS $Sec $PLoss
#        printf "3\n$DT $TM $call $name ID:$did TG:$TG"

else
	if [ "$call1" == "$call2" ]; then
		TG=$(echo "$list4" | awk '{print $4}')
		TS=$(echo "$list4" | awk '{print $5}')
		Sec=$(echo "$list4" | awk '{print $6}')
		PLoss=$(echo "$list4" | awk '{print $7}')
		printf "2\n$call $name\nID:$did TG:$TG TS:$TS Dur:$Sec PLoss:$PLoss"
	else
		tg1=$(echo "$list3" | awk '{print $4}')
		printf "1\n$call $name\nID:$did TG:$tg1"
	fi
fi

echo ""


#sudo sed -n '/received network end of voice transmission from/p' $f1 | sed 's/,//g' | sort -k2,3 | tail -1 | 
#awk '{print substr($2,6,5),substr($3,0,6),$6,$14,$17,$18,$20}'


exit
######  Mode 1
if [ "$2" == "1" ]; then
		echo "Check OK 1 = $2" >> /home/pi-star/lh2_start.txt 

	if [ "$1" == "1" ]; then
		cat /home/pi-star/lhlog.txt | sed -n '1,10p;11q' | awk '{printf "%5s %5s %6s %1s %6s %5s %3s \n", $1, $2, $4, $3, $5, $6, $7}'
	fi

	if [ "$1" == "2" ]; then
		cat /home/pi-star/lhlog.txt | sed -n '7,12p;13q' | awk '{printf "%5s %5s %-6s %1s %-6s %4s %4s\n", $1, $2, $4, $3, $5, $6, $7}'
	fi
	if [ "$1" == "3" ]; then
		cat /home/pi-star/lhlog.txt | sed -n '13,18p;19q' | awk '{printf "%5s %5s %-6s %1s %-6s %4s %4s\n", $1, $2, $4, $3, $5, $6, $7}' 
	fi
	if [ "$1" == "4" ]; then
		cat /home/pi-star/lhlog.txt | sed -n '19,24p;25q' | awk '{printf "%5s %5s %-6s %1s %-6s %4s %4s\n", $1, $2, $4, $3, $5, $6, $7}'
	fi
fi
######  Mode 2

if [ "$2" == "2" ]; then
                echo "Check OK 2 = $2" >> /home/pi-star/lh2_start.txt

	if [ "$1" == "1" ]; then
		list9=$(cat /home/pi-star/lhlog.txt | sed -n '1,6p;7q' | awk '{print $1, $2, $4, $5}' )
	fi

	if [ "$1" == "2" ]; then
		list9=$(cat /home/pi-star/lhlog.txt | sed -n '7,12p;13q' | awk '{print $1, $2, $4,$5}') 
	fi
	if [ "$1" == "3" ]; then
		list9=$(cat /home/pi-star/lhlog.txt | sed -n '13,18p;19q' | awk '{print $1, $2, $4, $5}') 
	fi
	if [ "$1" == "4" ]; then
		list9=$(cat /home/pi-star/lhlog.txt | sed -n '19,24p;25q' | awk '{print $1, $2, $4, $5}') 
	fi

	domode2
fi
#####  Mode 3


if [ "$2" == "3" ]; then
echo "1234567890123456789012345678901234567"
fi

