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
list1=$(sudo sed -n '/received network end of voice transmission from/p' $f1 | sed 's/,//g' | sort -r -k14,14 -k2,3)

f2=$(ls -tr /var/log/pi-star/MMDVM* | head -1)
list2=$(sudo sed -n '/received network end of voice transmission from/p' $f2 | sed 's/,//g' | sort -r -k14,14 -k2,3)

#echo "$f1" #Newest
#echo "$f2"
list3=$(echo "$list1" | awk '{print substr($2,6,5),substr($3,0,6),$6,$14,$17,$18,$20}')
list4=$(echo "$list2" | awk '{print substr($2,6,5),substr($3,0,6),$6,$14,$17,$18,$20}')
list1=""
list2=""

list6=$(echo "$list3" | awk '$4!=savestr {print $1,$2,$3,$4,$5,$6,$7; savestr=$4}' | sort -r -k4 | head -24)

lcnt=$(echo "$list6" | wc -l)

if [ $lcnt -lt 20 ]; then
	list7=$(echo "$list4" | awk '$4!=savestr {print $1,$2,$3,$4,$5,$6,$7; savestr=$4}' | sort -r -k4 | head -24)
	list6+="$list7"
fi

list4=""

list8=$(echo "$list6" | sort -r -k4 | awk '$4!=savestr {print $1,$2,$3,$4,$5,$6,$7; savestr=$4'} | sort -r -k1,2 | head -24)
echo "$list8" > /home/pi-star/lhlog.txt


#list7=$(echo "$list3" | awk 'BEGIN {format = "%-6s %-6s %-10s %-10s %-10s %-10s %s\n" } $4!=savestr  {printf  $1, $2, $3, $4, $5, $6, $7; savestr=$4}' | sort -r -k1,2 | head -24)
#list7=$(echo "$list3" | awk '{printf "%-6s %-6s %-10s %-10s %-10s %-10s %s\n", $1, $2, $3, $4, $5, $6, $7}' | sort -r -k1,2 | head -24)
#echo "$list7"
list3=""

n=0 
echo " Test 1a = $1"  >> /home/pi-star/lh2_start.txt


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

