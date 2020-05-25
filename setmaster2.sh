#!/bin/bash
############################################################
#  Set DMR Master Server from the Search Master Page       #
#  Param 1 is the Address		                   #
#  VE3RD                                      2020/05/22   #
############################################################
set -o errexit
set -o pipefail

if [ -z "$1" ]; then
        exit
fi


sudo /usr/local/sbin/mmdvmhost.service stop  > /dev/null
sudo mount -o remount,rw /
sudo /home/pi-star/SmartPhone/clearallmodes.sh
  	sudo sed -i '/\[DMR\]/!b;n;cEnable='"1"'' /etc/mmdvmhost
  	sudo sed -i '/\[DMR Network\]/!b;n;cEnable='"1"'' /etc/mmdvmhost
	sudo sed -i '/^\[/h;G;/DMR Network/s/\(Port=\).*/\162031/m;P;d'  /etc/mmdvmhost
	sudo sed -i '/^\[/h;G;/DMR Network/s/\(Address=\).*/\1'"$1"'/m;P;d'  /etc/mmdvmhost

	sudo /usr/local/sbin/mmdvmhost.service start > /dev/null
