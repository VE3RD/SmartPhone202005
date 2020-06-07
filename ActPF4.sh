#!/bin/bash
############################################################
#  Activate  Profile                                       #
#  VE3RD                                      2019/11/18   #
############################################################
set -o errexit
set -o pipefail
sudo mount -o remount,rw /

fromfile="/home/pi-star/SmartPhone/profiles.txt"
t0="/etc/mmdvmhost"
t1="/etc/mmdvmhost.tmp"


#pnum=$(echo "$1" | sed 's/^0*//')
echo "Profile $1 - 4" > /home/pi-star/ActivateProfile.txt

function exitfunction
{
	echo "Programmed Exit - %errtext" >> /home/pi-star/ActivateProfile.txt
	exit 1
}

function preprocess
{
	echo "Starting Preprocess Function 4" >> /home/pi-star/ActivateProfile.txt
	echo "Starting ClearAllModes" >> /home/pi-star/ActivateProfile.txt
        sudo /home/pi-star/SmartPhone/clearallmodes.sh
	echo "Clearing Modes Complete" >> /home/pi-star/ActivateProfile.txt
	echo "Pre-Process Function Complete" >> /home/pi-star/ActivateProfile.txt
	sudo cp /etc/mmdvmhost /etc/mmdvmhost.tmp

	if [  "$?" == 0 ]; then
  		echo "Backup mmdvmhozst OK!"
	else
  		echo "Backup mmdvmhozst FAILED!"
	fi
	echo "cp mmdvmhost .tmp"
}

function DisplayProfile
{
	echo "Callsign=$m5"
	echo "Frequency=$m3"
	echo "RXOffset=$m1"
	echo "Address=$m8"
	echo "Password=$m12"
exit
}

function readprofile0
{	
	echo "Reading Default Profile 0"  >> /home/pi-star/ActivateProfile.txt

                m1=$(sed -nr "/^\[Profile 4\]/ { :l /^RXOffset[ ]*=/ { s/.*=[ ]*//; p; q;}; n; b l;}" $fromfile)
                m2=$(sed -nr "/^\[Profile 4\]/ { :l /^TXOffset[ ]*=/ { s/.*=[ ]*//; p; q;}; n; b l;}" $fromfile)
                m3=$(sed -nr "/^\[Profile 4\]/ { :l /^RXFrequency[ ]*=/ { s/.*=[ ]*//; p; q;}; n; b l;}" $fromfile)
                m4=$(sed -nr "/^\[Profile 4\]/ { :l /^TXFrequency[ ]*=/ { s/.*=[ ]*//; p; q;}; n; b l;}" $fromfile)
                m5=$(sed -nr "/^\[Profile 4\]/ { :l /^Callsign[ ]*=/ { s/.*=[ ]*//; p; q;}; n; b l;}" $fromfile)
                m6=$(sed -nr "/^\[Profile 4\]/ { :l /^Id[ ]*=/ { s/.*=[ ]*//; p; q;}; n; b l;}" $fromfile)
                m7=$(sed -nr "/^\[Profile 4\]/ { :l /^Mode[ ]*=/ { s/.*=[ ]*//; p; q;}; n; b l;}" $fromfile)
                m8=$(sed -nr "/^\[Profile 4\]/ { :l /^Address[ ]*=/ { s/.*=[ ]*//; p; q;}; n; b l;}" $fromfile)
                m9=$(sed -nr "/^\[Profile 4\]/ { :l /^StartupDstId[ ]*=/ { s/.*=[ ]*//; p; q;}; n; b l;}" $fromfile)
                m10=$(sed -nr "/^\[Profile 4\]/ { :l /^Port[ ]*=/ { s/.*=[ ]*//; p; q;}; n; b l;}" $fromfile)
                m11=$(sed -nr "/^\[Profile 0\]/ { :l /^Id[ ]*=/ { s/.*=[ ]*//; p; q;}; n; b l;}" $fromfile)
                m12=$(sed -nr "/^\[Profile 4\]/ { :l /^Password[ ]*=/ { s/.*=[ ]*//; p; q;}; n; b l;}" $fromfile)
                m13=$(sed -nr "/^\[Profile 0\]/ { :l /^ExtId[ ]*=/ { s/.*=[ ]*//; p; q;}; n; b l;}" $fromfile)
	echo "Reading Default Profile 0 Complete"  >> /home/pi-star/ActivateProfile.txt

if [ "$m12" = "file" ]; then
  m12=$(sed -nr "/^\[Passwords\]/ { :l /^MNet3023954[ ]*=/ { s/.*=[ ]*//; p; q;}; n; b l;}"  /home/pi-star/SPass.txt)
  m11="$m6"
  m13=302095414
fi
#DisplayProfile
#	mt=$(sudo sed -n '/^[^#]*'"$m8"'/p' /usr/local/etc/DMR_Hosts.txt | sed -E "s/[[:space:]]+/|/g")
#       	mt=$(sudo sed -n "/\t$m8/p" /usr/local/etc/DMR_Hosts.txt |sed -E "s/[[:space:]]+/|/g")
#	m8=$( echo "$mt" | cut -d'|' -f3)
	echo "Processing Profile 0 m8 Address  = $m8  Complete"  >> /home/pi-star/ActivateProfile.txt

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
	
		echo "Processing Profile = 4,  Mode = $m7" >> /home/pi-star/ActivateProfile.txt	
		echo "Set Defaults Complete"  >> /home/pi-star/ActivateProfile.txt
test+=4

}		

function setdmr
{
sudo mount -o remount,rw /
        sudo sed -i '/^\[/h;G;/General/s/\(^Id=\).*/\1'"$m11"'/m;P;d' /etc/mmdvmhost.tmp
	sudo sed -i '/^\[/h;G;/DMR/s/\(^Id=\).*/\1'"$m6"'/m;P;d' /etc/mmdvmhost.tmp
        sudo sed -i '/^\[/h;G;/DMR]/s/\(^Id=\).*/\1'"$m13"'/m;P;d' /etc/mmdvmhost.tmp
	sudo sed -i '/^\[/h;G;/DMR]/s/\(Enable=\).*/\11/m;P;d' /etc/mmdvmhost.tmp 

       	sudo sed -i '/^\[/h;G;/DMR Network/s/\(Enable=\).*/\11/m;P;d' /etc/mmdvmhost.tmp
	sudo sed -i '/^\[/h;G;/DMR Network/s/\(^Address=\).*/\1'"$m8"'/m;P;d' /etc/mmdvmhost.tmp
	sudo sed -i '/^\[/h;G;/DMR Network/s/\(^Port=\).*/\1'"$m10"'/m;P;d' /etc/mmdvmhost.tmp
	sudo sed -i '/^\[/h;G;/DMR Network/s/\(Password=\).*/\1'"$m12"'/m;P;d' /etc/mmdvmhost.tmp
        sudo sed -i '/^\[/h;G;/DMR Network/s/\(Local=\).*/\162035/m;P;d' /etc/mmdvmhost.tmp
        sudo sed -i '/^\[/h;G;/DMR Network/s/\(ModeHang=\).*/\115/m;P;d' /etc/mmdvmhost.tmp

	echo "Set DMR Complete" >> /home/pi-star/ActivateProfile.txt

}
####################

echo "Starting pre-processes" >> /home/pi-star/ActivateProfile.txt
preprocess

echo "Starting readprofile0" >> /home/pi-star/ActivateProfile.txt
readprofile0

echo "Starting setdefaults" >> /home/pi-star/ActivateProfile.txt
setdefaults
setdmr
echo "Selection Processing Complete" >> /home/pi-star/ActivateProfile.txt

echo "Processing Profile = 4  Mode = $m7  Ready for Reboot" >> /home/pi-star/ActivateProfile.txt

#echo "Profile 4 - Loaded  - $m7"
systemctl stop mmdvmhost
systemctl stop mmdvmhost.timer
sudo cp /etc/mmdvmhost.tmp /etc/mmdvmhost

if [  "$?" == 0 ]; then
  echo "Resrore mmdvmhost OK!"
else
  echo "Restore mmdvmhost FAILED!"
fi

systemctl start mmdvmhost.timer
#systemctl start mmdvmhost
sudo mmdvmhost.service restart
echo "Profile Script Completed Processing Test=$test"
echo "Profile Script Completed Processing Test=$test"  >> /home/pi-star/ActivateProfile.txt

#startprocesses
#reboot

