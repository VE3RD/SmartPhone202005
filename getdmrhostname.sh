#!/bin/bash
############################################################
#  Lookup DMR Host in /usr/local/etc/DMR_Hosts.txt         #
#  Return IP Address.                                      #
#                                                          #
#                                                          #
#  VE3RD                                        2019-01-11 #
############################################################
set -o errexit
set -o pipefail
# Use passed DMR Master name to lookup IP address
declare LEN number

fromfile=/usr/local/etc/Nextion_Support/profiles.txt
       
Addr=$(sed -nr "/^\[DMR Network\]/ { :l /^Address[ ]*=/ { s/.*=[ ]*//; p; q;}; n; b l;}" /etc/mmdvmhost)
#echo "Addr=$Addr"

#Line="HB_US_TGIF_Network              0000    tgif.network                    passw0rd        62031"
#sed "/$Line/d" /usr/local/etc/DMR_Hosts.txt
 
mt=$(sudo sed -n '/^[^#]*\t'"$Addr"'/p' /usr/local/etc/DMR_Hosts.txt | sed -E "s/[[:space:]]+/|/g" | head -1)
#echo "$mt"

mt1=$( echo "$mt" | cut -d'|' -f1)
mt2=$( echo "$mt" | cut -d'|' -f2)
mt3=$( echo "$mt" | cut -d'|' -f3)
mt4=$( echo "$mt" | cut -d'|' -f4)
mt5=$( echo "$mt" | cut -d'|' -f5)

#mt2=$(sed -nr "/^\[Profile 0\]/ { :l /^ExtId[ ]*=/ { s/.*=[ ]*//; p; q;}; n; b l;}" $fromfile)

if [ -z "$mt" ]; then
	echo "Nothing|Found|Try|Another|Search"
else
	echo "$mt1"
#	echo "$mt"
fi

