#!/bin/bash
############################################################
#  Activate  Profile 1                                     #
#  VE3RD                                      2020/05/17   #
############################################################
set -o errexit
set -o pipefail
sudo mount -o remount,rw /
echo "Activating Profile 2"
fromfile="/home/pi-star/SmartPhone/profiles.txt"


pnum=$(echo "$1" | sed 's/^0*//')
echo "Profile $1 - 1" > /home/pi-star/ActivateProfile.txt

	echo "Starting ClearAllModes" >> /home/pi-star/ActivateProfile.txt
	sudo /home/pi-star/SmartPhone/clearallmodes.sh
	echo "Reading Default Profile 0"  >> /home/pi-star/ActivateProfile.txt

                m1=$(sed -nr "/^\[Profile 2\]/ { :l /^RXOffset[ ]*=/ { s/.*=[ ]*//; p; q;}; n; b l;}" $fromfile)
                m2=$(sed -nr "/^\[Profile 2\]/ { :l /^TXOffset[ ]*=/ { s/.*=[ ]*//; p; q;}; n; b l;}" $fromfile)
                m3=$(sed -nr "/^\[Profile 2\]/ { :l /^RXFrequency[ ]*=/ { s/.*=[ ]*//; p; q;}; n; b l;}" $fromfile)
                m4=$(sed -nr "/^\[Profile 2\]/ { :l /^TXFrequency[ ]*=/ { s/.*=[ ]*//; p; q;}; n; b l;}" $fromfile)
                m5=$(sed -nr "/^\[Profile 2\]/ { :l /^Callsign[ ]*=/ { s/.*=[ ]*//; p; q;}; n; b l;}" $fromfile)
                m6=$(sed -nr "/^\[Profile 2\]/ { :l /^Id[ ]*=/ { s/.*=[ ]*//; p; q;}; n; b l;}" $fromfile)
                m7=$(sed -nr "/^\[Profile 2\]/ { :l /^Mode[ ]*=/ { s/.*=[ ]*//; p; q;}; n; b l;}" $fromfile)
                m8=$(sed -nr "/^\[Profile 2\]/ { :l /^Address[ ]*=/ { s/.*=[ ]*//; p; q;}; n; b l;}" $fromfile)
                m9=$(sed -nr "/^\[Profile 2\]/ { :l /^StartupDstId[ ]*=/ { s/.*=[ ]*//; p; q;}; n; b l;}" $fromfile)
                m10=$(sed -nr "/^\[Profile 2\]/ { :l /^Port[ ]*=/ { s/.*=[ ]*//; p; q;}; n; b l;}" $fromfile)
                m11=$(sed -nr "/^\[Profile 0\]/ { :l /^Id[ ]*=/ { s/.*=[ ]*//; p; q;}; n; b l;}" $fromfile)
                m12=$(sed -nr "/^\[Profile 2\]/ { :l /^Password[ ]*=/ { s/.*=[ ]*//; p; q;}; n; b l;}" $fromfile)
                m13=$(sed -nr "/^\[Profile 0\]/ { :l /^ExtId[ ]*=/ { s/.*=[ ]*//; p; q;}; n; b l;}" $fromfile)
	echo "Reading Default Profile 0 Complete"  >> /home/pi-star/ActivateProfile.txt

#	mt=$(sudo sed -n '/^[^#]*'"$m8a"'/p' /usr/local/etc/DMR_Hosts.txt | sed -E "s/[[:space:]]+/|/g")
#       	mt=$(sudo sed -n "/\t$m8a/p" /usr/local/etc/DMR_Hosts.txt |sed -E "s/[[:space:]]+/|/g")

#	m8=$( echo "$mt" | cut -d'|' -f3)

	sudo mount -o remount,rw /

	echo "Starting Set Defaults $1" >> /home/pi-star/ActivateProfile.txt

	
	 sudo sed -i '/^\[/h;G;/Modem/s/\(RXOffset=\).*/\1'"$m1"'/m;P;d' /etc/mmdvmhost.tmp 
	 sudo sed -i '/^\[/h;G;/Modem/s/\(TXOffset=\).*/\1'"$m2"'/m;P;d' /etc/mmdvmhost.tmp 
	 sudo sed -i '/^\[/h;G;/Info/s/\(RXFrequency=\).*/\1'"$m3"'/m;P;d' /etc/mmdvmhost.tmp
	 sudo sed -i '/^\[/h;G;/Info/s/\(TXFrequency=\).*/\1'"$m4"'/m;P;d' /etc/mmdvmhost.tmp
	 sudo sed -i '/^\[/h;G;/General/s/\(Callsign=\).*/\1'"$m5"'/m;P;d' /etc/mmdvmhost.tmp
	 sudo sed -i '/^\[/h;G;/General/s/\(Id=\).*/\1'"$m6"'/m;P;d' /etc/mmdvmhost.tmp

        sudo sed -i '/^\[/h;G;/DMR]/s/\(^Id=\).*/\1'"$m13"'/m;P;d' /etc/mmdvmhost.tmp
	sudo sed -i '/^\[/h;G;/DMR]/s/\(Enable=\).*/\11/m;P;d' /etc/mmdvmhost.tmp 

       	sudo sed -i '/^\[/h;G;/DMR Network/s/\(Enable=\).*/\11/m;P;d' /etc/mmdvmhost.tmp
        sudo sed -i '/^\[/h;G;/DMR Network/s/\(Local=\).*/\162035/m;P;d' /etc/mmdvmhost.tmp
        sudo sed -i '/^\[/h;G;/DMR Network/s/\(ModeHang=\).*/\115/m;P;d' /etc/mmdvmhost.tmp
        sudo sed -i '/^\[/h;G;/DMR Network/s/\(Address=\).*/\1'"$m8"'/m;P;d' /etc/mmdvmhost.tmp

#echo "Profile 1 - Loaded  - $m7"
sudo mmdvmhost.service stop > /dev/null
sudo cp -f /etc/mmdvmhost.tmp /etc/mmdvmhost

sudo mmdvmhost.service restart > /dev/null

echo "Prime_TGIF Network Started"
echo "Profile Script Completed Processing Test=$test"  >> /home/pi-star/ActivateProfile.txt


