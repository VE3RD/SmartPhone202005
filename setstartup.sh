#!/bin/bash
#########################################################
#  Nextion Support for Nextion screen. Used to dump     #
#  current TG and change to TG4000                      #
#  Check Firewall added by VE3RD			#
#		                                        #
#  K5MRE & KF6S & VE3RD                     2021-04-12  #
#########################################################
# Use passed TS if present or default to TS2 (zero based code=1)
if [ -z "$1" ]; then
 exit
fi

TG="$1"


#TS="0" really means TS=1
TS="1"

function CheckMode {
## gate indicates use of the DMRGateway and Network 4
addr=$(sed -nr "/^\[DMR Network\]/ { :l /^Address[ ]*=/ { s/.*=[ ]*//; p; q;}; n; b l;}" /etc/mmdvmhost)
if [ "$addr" = "127.0.0.1" ] ; then
 	ID=$(sed -nr "/^\[DMR Network 4\]/ { :l /^Id[ ]*=/ { s/.*=[ ]*//; p; q;}; n; b l;}" /etc/dmrgateway)

else
	ID=$(sed -nr "/^\[DMR\]/ { :l /^Id[ ]*=/ { s/.*=[ ]*//; p; q;}; n; b l;}" /etc/mmdvmhost)
fi

}


CheckMode

echo "Setting TG to $TG" > /home/pi-star/settg.log
timeout 1 bash -c 'cat < /dev/null > /dev/tcp/tgif.network/5040'
if  [ $? = 0 ]; then
	curl -s http://tgif.network:5040/api/sessions/update/$ID/$TS/$TG
	## To check arquments being passed to command take off the ## in front of echo below
	#echo curl -s http://tgif.network:5040/api/sessions/update/$ID/$TS/$TG
        echo "Setting $TG" > /home/pi-star/settg.log
else
  echo 5040
#  echo Check Firewall Rule 5040
	sudo sh -c 'echo "iptables -A OUTPUT -p tcp --dport 5040 -j ACCEPT" > /root/ipv4.fw'
	sudo pistar-firewall

fi

