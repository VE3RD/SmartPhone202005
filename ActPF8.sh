#!/bin/bash
############################################################
#  Activate  Profile 8                                     #
#  VE3RD                                      2019/11/18   #
############################################################
set -o errexit
set -o pipefail
sudo mount -o remount,rw /

declare -i pnum
declare -i test 

test=0
chmod 766 /etc/mmdvmhost
fromfile="/home/pi-star/SmartPhone/profiles.txt"
t0="/etc/mmdvmhost"
t1="/etc/mmdvmhost.tmp"


pnum=$(echo "$1" | sed 's/^0*//')
echo "Profile $1 - 8" > /home/pi-star/ActivateProfile.txt

function exitfunction
{
	echo "Programmed Exit - %errtext" >> /home/pi-star/ActivateProfile.txt
	exit 1
}


function readprofile0
{	
	echo "Reading Defaults"  >> /home/pi-star/ActivateProfile.txt

                m1=$(sed -nr "/^\[Profile 8\]/ { :l /^RXOffset[ ]*=/ { s/.*=[ ]*//; p; q;}; n; b l;}" $fromfile)
                m2=$(sed -nr "/^\[Profile 8\]/ { :l /^TXOffset[ ]*=/ { s/.*=[ ]*//; p; q;}; n; b l;}" $fromfile)
                m3=$(sed -nr "/^\[Profile 8\]/ { :l /^RXFrequency[ ]*=/ { s/.*=[ ]*//; p; q;}; n; b l;}" $fromfile)
                m4=$(sed -nr "/^\[Profile 8\]/ { :l /^TXFrequency[ ]*=/ { s/.*=[ ]*//; p; q;}; n; b l;}" $fromfile)
                m5=$(sed -nr "/^\[Profile 8\]/ { :l /^Callsign[ ]*=/ { s/.*=[ ]*//; p; q;}; n; b l;}" $fromfile)
                m6=$(sed -nr "/^\[Profile 8\]/ { :l /^Id[ ]*=/ { s/.*=[ ]*//; p; q;}; n; b l;}" $fromfile)
                m7=$(sed -nr "/^\[Profile 8\]/ { :l /^Mode[ ]*=/ { s/.*=[ ]*//; p; q;}; n; b l;}" $fromfile)
                m8=$(sed -nr "/^\[Profile 8\]/ { :l /^Address[ ]*=/ { s/.*=[ ]*//; p; q;}; n; b l;}" $fromfile)
                m9=$(sed -nr "/^\[Profile 8\]/ { :l /^StartupDstId[ ]*=/ { s/.*=[ ]*//; p; q;}; n; b l;}" $fromfile)
                m10=$(sed -nr "/^\[Profile 8\]/ { :l /^Port[ ]*=/ { s/.*=[ ]*//; p; q;}; n; b l;}" $fromfile)
                m11=$(sed -nr "/^\[Profile 0\]/ { :l /^Id[ ]*=/ { s/.*=[ ]*//; p; q;}; n; b l;}" $fromfile)
                m12=$(sed -nr "/^\[Profile 8\]/ { :l /^Password[ ]*=/ { s/.*=[ ]*//; p; q;}; n; b l;}" $fromfile)
                m13=$(sed -nr "/^\[Profile 0\]/ { :l /^ExtId[ ]*=/ { s/.*=[ ]*//; p; q;}; n; b l;}" $fromfile)
	echo "Reading Default Profile 0 Complete"  >> /home/pi-star/ActivateProfile.txt

}

function setdefaults
{	
sudo mount -o remount,rw /

	echo "Starting Set Defaults $1" >> /home/pi-star/ActivateProfile.txt

	
		 sudo sed -i '/^\[/h;G;/Modem/s/\(RXOffset=\).*/\1'"$m1"'/m;P;d' /etc/mmdvmhost.tmp 
		 sudo sed -i '/^\[/h;G;/Modem/s/\(TXOffset=\).*/\1'"$m2"'/m;P;d' /etc/mmdvmhost.tmp 
		 sudo sed -i '/^\[/h;G;/Info/s/\(RXFrequency=\).*/\1'"$m3"'/m;P;d' /etc/mmdvmhost.tmp
		 sudo sed -i '/^\[/h;G;/Info/s/\(TXFrequency=\).*/\1'"$m4"'/m;P;d' /etc/mmdvmhost.tmp
		 sudo sed -i '/^\[/h;G;/General/s/\(Callsign=\).*/\1'"$m5"'/m;P;d' /etc/mmdvmhost.tmp
		 sudo sed -i '/^\[/h;G;/General/s/\(Id=\).*/\1'"$m6"'/m;P;d' /etc/mmdvmhost.tmp
		 sudo sed -i '/^\[/h;G;/DMR/s/\(Id=\).*/\1'"$m6"'/m;P;d' /etc/mmdvmhost.tmp
	
		echo "Processing Profile = 8,  Mode = $m7" >> /home/pi-star/ActivateProfile.txt	
		echo "Set Defaults Complete"  >> /home/pi-star/ActivateProfile.txt

}		

function setysf
{
	echo "Set Ysf Not Implemented Yet" >> /home/pi-star/ActivateProfile.txt
		 sudo sed -i '/^\[/h;G;/System Fusion/s/\(^Enable=\).*/\11/m;P;d' /etc/mmdvmhost.tmp
		 sudo sed -i '/^\[/h;G;/System Fusion Network/s/\(^Enable=\).*/\11/m;P;d' /etc/mmdvmhost.tmp
		 sudo sed -i '/^\[/h;G;/General/s/\(^Id=\).*/\1'"$m11"'/m;P;d' /etc/mmdvmhost.tmp
		 sudo sed -i '/^\[/h;G;/DMR/s/\(^Id=\).*/\1'"$m11"'/m;P;d' /etc/mmdvmhost.tmp
}

function setysfgateway
{
		 sudo sed -i '/^\[/h;G;/YSF Network/s/\(Enable=\).*/\11/m;P;d' /etc/ysfgateway
		 sudo sed -i '/^\[/h;G;/FCS Network/s/\(Enable=\).*/\11/m;P;d' /etc/ysfgateway
		 sudo sed -i '/^\[/h;G;/Network/s/\(Startup=\).*/\1YSF2DMR/m;P;d' /etc/ysfgateway
		 sudo sed -i '/^\[/h;G;/General/s/\(^Id=\).*/\1'"$m6"'/m;P;d' /etc/ysfgateway
		 sudo sed -i '/^\[/h;G;/Info/s/\(RXFrequency=\).*/\1'"$m3"'/m;P;d' /etc/ysfgateway
		 sudo sed -i '/^\[/h;G;/Info/s/\(TXFrequency=\).*/\1'"$m4"'/m;P;d' /etc/ysfgateway

}
####################


sudo /home/pi-star/SmartPhone/clearallmodes.sh
sudo cp /etc/mmdvmhost /etc/mmdvmhost.tmp


echo "Starting readprofile0" >> /home/pi-star/ActivateProfile.txt
readprofile0

echo "Starting setdefaults" >> /home/pi-star/ActivateProfile.txt
setdefaults

echo "Selection Processing Complete" >> /home/pi-star/ActivateProfile.txt

		 sudo sed -i '/^\[/h;G;/Enabled/s/\(Enabled=\).*/\11/m;P;d' /etc/ysf2dmr
		 sudo sed -i '/^\[/h;G;/YSF Network/s/\(EnableWiresX=\).*/\11/m;P;d' /etc/ysf2dmr
		 sudo sed -i '/^\[/h;G;/YSF Network/s/\(LocalPort=\).*/\142013/m;P;d' /etc/ysf2dmr

		 sudo sed -i '/^\[/h;G;/DMR Network/s/\(EnableUnlink=\).*/\10/m;P;d' /etc/ysf2dmr
		 sudo sed -i '/^\[/h;G;/DMR Network/s/\(StartupDstId=\).*/\1'"$m9"'/m;P;d' /etc/ysf2dmr
		 sudo sed -i '/^\[/h;G;/DMR Network/s/\(^Address=\).*/\1'"$m8"'/m;P;d' /etc/ysf2dmr
		 sudo sed -i '/^\[/h;G;/DMR Network/s/\(^Port=\).*/\1'"$m10"'/m;P;d' /etc/ysf2dmr
		 sudo sed -i '/^\[/h;G;/DMR Network/s/\(Local=\).*/\162035/m;P;d' /etc/ysf2dmr
		 sudo sed -i '/^\[/h;G;/DMR Network/s/\(Password=\).*/\1'"$m12"'/m;P;d' /etc/ysf2dmr
		 sudo sed -i '/^\[/h;G;/DMR Network/s/\(^Id=\).*/\1'"$m13"'/m;P;d' /etc/ysf2dmr
		 sudo sed -i '/^\[/h;G;/DMR Network/s/\(Enabled=\).*/\11/m;P;d' /etc/ysf2dmr
		 sudo sed -i '/^\[/h;G;/Info/s/\(RXFrequency=\).*/\1'"$m3"'/m;P;d' /etc/ysf2dmr
		 sudo sed -i '/^\[/h;G;/Info/s/\(TXFrequency=\).*/\1'"$m4"'/m;P;d' /etc/ysf2dmr
		 sudo sed -i '/^\[/h;G;/Log/s/\(FileLevel=\).*/\12/m;P;d' /etc/ysf2dmr

		 sudo sed -i '/^\[/h;G;/System Fusion/s/\(^Enable=\).*/\11/m;P;d' /etc/mmdvmhost.tmp
		 sudo sed -i '/^\[/h;G;/System Fusion Network/s/\(^Enable=\).*/\11/m;P;d' /etc/mmdvmhost.tmp
		 sudo sed -i '/^\[/h;G;/General/s/\(^Id=\).*/\1'"$m11"'/m;P;d' /etc/mmdvmhost.tmp
		 sudo sed -i '/^\[/h;G;/DMR/s/\(^Id=\).*/\1'"$m11"'/m;P;d' /etc/mmdvmhost.tmp

echo "Processing Profile = 8  Mode = $m7  Ready for Reboot" >> /home/pi-star/ActivateProfile.txt

#echo "Profile 8 - Loaded  - $m7"
systemctl stop mmdvmhost
systemctl stop mmdvmhost.timer
sudo rm /etc/mmdvmhost
sudo mv -f /etc/mmdvmhost.tmp /etc/mmdvmhost

 m1=$(sed -nr "/^\[DMR\]/ { :l /^ModeHang[ ]*=/ { s/.*=[ ]*//; p; q;}; n; b l;}" /etc/mmdvmhost)
if [ "$ml" == 0 ]; then
 sudo cp -f /etc/mmdvmhost.tmp /etc/mmdvmhost
fi
 m1=$(sed -nr "/^\[DMR\]/ { :l /^ModeHang[ ]*=/ { s/.*=[ ]*//; p; q;}; n; b l;}" /etc/mmdvmhost)
if [ "$ml" == 0 ]; then
 sudo rsync  /etc/mmdvmhost.tmp /etc/mmdvmhost
fi

if [  "$?" == 0 ]; then
  echo "Resrore mmdvmhost OK!"
else
  echo "Restore mmdvmhost FAILED!"
fi

systemctl start mmdvmhost
systemctl start mmdvmhost.timer
systemctl start ysfgateway
systemctl start ysf2dmr

#ysfgateway.service restart
#ysf2dmr.service restart 
#dmrgateway.service restart
echo "Profile Script Completed Processing Test=$test"
echo "Profile Script Completed Processing Test=$test"  >> /home/pi-star/ActivateProfile.txt

#startprocesses
#reboot

