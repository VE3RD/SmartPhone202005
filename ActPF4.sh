#!/bin/bash
############################################################
#  Activate  Profile                                       #
#  VE3RD                                      2019/11/18   #
############################################################
set -o errexit
set -o pipefail
sudo mount -o remount,rw /

declare -i pnum
declare -i test 

test=0
chmod 766 /etc/mmdvmhost

fromfile="/usr/local/etc/Nextion_Support/profiles.txt"
t0="/etc/mmdvmhost"
t1="/etc/mmdvmhost.tmp"


pnum=$(echo "$1" | sed 's/^0*//')
echo "Profile $1 - $pnum" > /home/pi-star/ActivateProfile.txt

function exitfunction
{
	echo "Programmed Exit - %errtext" >> /home/pi-star/ActivateProfile.txt
	exit 1
}

function preprocess
{
	echo "Starting Preprocess Function $pnum" >> /home/pi-star/ActivateProfile.txt
	echo "Starting ClearAllModes" >> /home/pi-star/ActivateProfile.txt
	sudo /usr/local/etc/Nextion_Support/clearallmodes.sh
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


function readprofile0
{	
	echo "Reading Default Profile 0"  >> /home/pi-star/ActivateProfile.txt

                m1=$(sed -nr "/^\[Profile $pnum\]/ { :l /^RXOffset[ ]*=/ { s/.*=[ ]*//; p; q;}; n; b l;}" $fromfile)
                m2=$(sed -nr "/^\[Profile $pnum\]/ { :l /^TXOffset[ ]*=/ { s/.*=[ ]*//; p; q;}; n; b l;}" $fromfile)
                m3=$(sed -nr "/^\[Profile $pnum\]/ { :l /^RXFrequency[ ]*=/ { s/.*=[ ]*//; p; q;}; n; b l;}" $fromfile)
                m4=$(sed -nr "/^\[Profile $pnum\]/ { :l /^TXFrequency[ ]*=/ { s/.*=[ ]*//; p; q;}; n; b l;}" $fromfile)
                m5=$(sed -nr "/^\[Profile $pnum\]/ { :l /^Callsign[ ]*=/ { s/.*=[ ]*//; p; q;}; n; b l;}" $fromfile)
                m6=$(sed -nr "/^\[Profile $pnum\]/ { :l /^Id[ ]*=/ { s/.*=[ ]*//; p; q;}; n; b l;}" $fromfile)
                m7=$(sed -nr "/^\[Profile $pnum\]/ { :l /^Mode[ ]*=/ { s/.*=[ ]*//; p; q;}; n; b l;}" $fromfile)
                m8=$(sed -nr "/^\[Profile $pnum\]/ { :l /^Address[ ]*=/ { s/.*=[ ]*//; p; q;}; n; b l;}" $fromfile)
                m9=$(sed -nr "/^\[Profile $pnum\]/ { :l /^StartupDstId[ ]*=/ { s/.*=[ ]*//; p; q;}; n; b l;}" $fromfile)
                m10=$(sed -nr "/^\[Profile $pnum\]/ { :l /^Port[ ]*=/ { s/.*=[ ]*//; p; q;}; n; b l;}" $fromfile)
                m11=$(sed -nr "/^\[Profile 0\]/ { :l /^Id[ ]*=/ { s/.*=[ ]*//; p; q;}; n; b l;}" $fromfile)
                m12=$(sed -nr "/^\[Profile $pnum\]/ { :l /^Password[ ]*=/ { s/.*=[ ]*//; p; q;}; n; b l;}" $fromfile)
                m13=$(sed -nr "/^\[Profile 0\]/ { :l /^ExtId[ ]*=/ { s/.*=[ ]*//; p; q;}; n; b l;}" $fromfile)
	echo "Reading Default Profile 0 Complete"  >> /home/pi-star/ActivateProfile.txt

	mt=$(sudo sed -n '/^[^#]*'"$m8"'/p' /usr/local/etc/DMR_Hosts.txt | sed -E "s/[[:space:]]+/|/g")
       	mt=$(sudo sed -n "/\t$m8/p" /usr/local/etc/DMR_Hosts.txt |sed -E "s/[[:space:]]+/|/g")

	m8=$( echo "$mt" | cut -d'|' -f3)
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
	
		echo "Processing Profile = $pnum,  Mode = $m7" >> /home/pi-star/ActivateProfile.txt	
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
	sudo sed -i '/^\[/h;G;/DMR Network/s/\(^Address=\).*/\1'"$m8"'/m;P;d' /etc/dmr2nxdn
	sudo sed -i '/^\[/h;G;/DMR Network/s/\(^Port=\).*/\1'"$m10"'/m;P;d' /etc/dmr2nxdn
	sudo sed -i '/^\[/h;G;/DMR Network/s/\(Password=\).*/\1'"$m12"'/m;P;d' /etc/dmr2nxdn
        sudo sed -i '/^\[/h;G;/DMR Network/s/\(Local=\).*/\162035/m;P;d' /etc/mmdvmhost.tmp
        sudo sed -i '/^\[/h;G;/DMR Network/s/\(ModeHang=\).*/\115/m;P;d' /etc/mmdvmhost.tmp

	echo "Set DMR Complete" >> /home/pi-star/ActivateProfile.txt
test+=8

}

function setysf
{
	echo "Set Ysf Not Implemented Yet" >> /home/pi-star/ActivateProfile.txt
		 sudo sed -i '/^\[/h;G;/System Fusion/s/\(^Enable=\).*/\11/m;P;d' /etc/mmdvmhost.tmp
		 sudo sed -i '/^\[/h;G;/System Fusion Network/s/\(^Enable=\).*/\11/m;P;d' /etc/mmdvmhost.tmp
		 sudo sed -i '/^\[/h;G;/General/s/\(^Id=\).*/\1'"$m11"'/m;P;d' /etc/mmdvmhost.tmp
		 sudo sed -i '/^\[/h;G;/DMR/s/\(^Id=\).*/\1'"$m11"'/m;P;d' /etc/mmdvmhost.tmp
test+=8

}

function setysfgateway
{
		 sudo sed -i '/^\[/h;G;/YSF Network/s/\(Enable=\).*/\11/m;P;d' /etc/ysfgateway
		 sudo sed -i '/^\[/h;G;/FCS Network/s/\(Enable=\).*/\11/m;P;d' /etc/ysfgateway
		 sudo sed -i '/^\[/h;G;/Network/s/\(Startup=\).*/\1YSF2DMR/m;P;d' /etc/ysfgateway
		 sudo sed -i '/^\[/h;G;/General/s/\(^Id=\).*/\1'"$m6"'/m;P;d' /etc/ysfgateway
		 sudo sed -i '/^\[/h;G;/Info/s/\(RXFrequency=\).*/\1'"$m3"'/m;P;d' /etc/ysfgateway
		 sudo sed -i '/^\[/h;G;/Info/s/\(TXFrequency=\).*/\1'"$m4"'/m;P;d' /etc/ysfgateway
test+=16

}
####################

if [ -z "$1" ]; then
#	echo "No Profile Number"
	echo "Missing or Invalid Profile Number" >> /home/pi-star/ActivateProfile.txt
	echo "Missing or Invalid Profile Number $1" >> /home/pi-star/ActivateProfile.txt
   	exit
else


echo "Starting pre-processes" >> /home/pi-star/ActivateProfile.txt
preprocess

echo "Starting readprofile0" >> /home/pi-star/ActivateProfile.txt
readprofile0

if [ "$m7" == 'NXDN2DMR' ]; then 
	exit
fi

echo "Starting setdefaults" >> /home/pi-star/ActivateProfile.txt
setdefaults

echo "Selection Processing Complete" >> /home/pi-star/ActivateProfile.txt


	if [ "$m7" = 'DMR' ]; then 
			sudo mount -o remount,rw /
			setdmr
                         sudo sed -i '/^\[/h;G;/DMR Network/s/\(^Address=\).*/\1'"$m8"'/m;P;d'  /etc/mmdvmhost.tmp

			echo "$m7  $m8"  >> /home/pi-star/ActivateProfile.txt
test+=32
 
	fi 
        if [ "$m7" = 'DMRGateway' ]; then
	echo "Set DMR "	
		setdmr
	echo "Starting Gateway"
                         sudo sed -i '/^\[/h;G;/DMR Network/s/\(^Address=\).*/\1127.0.0.1/m;P;d'  /etc/mmdvmhost.tmp
	echo "Gateway 1"              
		         sudo sed -i '/^\[/h;G;/DMR Network/s/\(ModeHang=\).*/\110/m;P;d'  /etc/mmdvmhost.tmp
        echo "Gateway 2"                
        	
		         sudo sed -i '/^\[/h;G;/General/s/\(^Id=\).*/\1'"$m11"'/m;P;d'  /etc/mmdvmhost.tmp
	echo "Gateway 3"                
                
		         sudo sed -i '/^\[/h;G;/DMR]/s/\(^Id=\).*/\1'"$m13"'/m;P;d'  /etc/mmdvmhost.tmp
	echo "Gateway 4"                
		
			sudo dmrgateway.service restart
	echo "Gateway 5"                
                
        echo "$m7  $m8"  >> /home/pi-star/ActivateProfile.txt
echo "Finished DMR Gateway Script"
        fi

	if [ "$m7" = 'DMR2YSF' ]; then
		setdmr
		 sudo sed -i '/^\[/h;G;/General/s/\(^Id=\).*/\1'"$m11"'/m;P;d' /etc/mmdvmhost.tmp
		 sudo sed -i '/^\[/h;G;/DMR/s/\(^Id=\).*/\1'"$m6"'/m;P;d' /etc/mmdvmhost.tmp
		 sudo sed -i '/^\[/h;G;/DMR Network/s/\(^Address=\).*/\1127.0.0.2/m;P;d' /etc/mmdvmhost.tmp

		 sudo sed -i '/^\[/h;G;/DMR Network/s/\(^Port=\).*/\162033/m;P;d' /etc/mmdvmhost.tmp
		 sudo sed -i '/^\[/h;G;/DMR Network/s/\(^Local=\).*/\162034/m;P;d' /etc/mmdvmhost.tmp
		 sudo sed -i '/^\[/h;G;/DMR Network/s/\(^Password=\).*/\1'"none"'/m;P;d' /etc/mmdvmhost.tmp

		 sudo sed -i '/^\[/h;G;/DMR Network/s/\(^Id=\).*/\1'"$m13"'/m;P;d' /etc/dmr2ysf
		 sudo sed -i '/^\[/h;G;/DMR Network/s/\(DefaultDstId=\).*/\1'"$m9"'/m;P;d' /etc/dmr2ysf
		 sudo sed -i '/^\[/h;G;/Enabled/s/\(Enabled=\).*/\11/m;P;d' /etc/dmr2ysf
		 sudo sed -i '/^\[/h;G;/Log/s/\(FileLevel=\).*/\12/m;P;d' /etc/dmr2ysf


		 sudo sed -i '/^\[/h;G;/DMR Network 3/s/\(Enabled=\).*/\11/m;P;d' /etc/dmrgateway
		 sudo sed -i '/^\[/h;G;/DMR Network 3/s/\(Name=\).*/\1'"DMR2YSF_Cross-Over"'/m;P;d' /etc/dmrgateway
		 sudo sed -i '/^\[/h;G;/DMR Network 3/s/\(Id=\).*/\1'"$m13"'/m;P;d' /etc/dmrgateway
		 sudo sed -i '/^\[/h;G;/DMR Network 3/s/\(^Address=\).*/\1'"127.0.0.1"'/m;P;d' /etc/dmrgateway
		 sudo sed -i '/^\[/h;G;/DMR Network 3/s/\(^Port=\).*/\162033/m;P;d' /etc/dmrgateway
		 sudo sed -i '/^\[/h;G;/DMR Network 3/s/\(Local=\).*/\162034/m;P;d' /etc/dmrgateway
		 sudo sed -i '/^\[/h;G;/DMR Network 3/s/\(Password=\).*/\1'"PASSWORD"'/m;P;d' /etc/dmrgateway

                sudo /usr/local/sbin/dmr2ysf.service restart  
                sudo /usr/local/sbin/dmrgateway.service restart  
test+=32

	fi

	if [ "$m7" = 'DMR2NXDN' ]; then
		setdmr
		 sudo sed -i '/^\[/h;G;/DMR Network/s/\(^Address=\).*/\1127.0.0.3/m;P;d' /etc/mmdvmhost.tmp
		sudo sed -i '/^\[/h;G;/DMR Network/s/\(^Id=\).*/\1'"$m13"'/m;P;d' /etc/dmr2nxdn

		 sudo sed -i '/^\[/h;G;/DMR Network/s/\(^Port=\).*/\162035/m;P;d' /etc/mmdvmhost.tmp
		 sudo sed -i '/^\[/h;G;/DMR Network/s/\(^Local=\).*/\162034/m;P;d' /etc/mmdvmhost.tmp
		 sudo sed -i '/^\[/h;G;/DMR Network/s/\(^Password=\).*/\1'"none"'/m;P;d' /etc/mmdvmhost.tmp
		 sudo sed -i '/^\[/h;G;/Enabled/s/\(Enabled=\).*/\11/m;P;d' /etc/dmr2nxdn
	sudo sed -i '/^\[/h;G;/DMR Network/s/\(StartupDstId=\).*/\1'"$m9"'/m;P;d' /etc/dmr2nxdn

                sudo sed -i '/\[DMR Network\]/!b;n;cEnabled='"1"'' /etc/dmr2nxdn
		 sudo sed -i '/^\[/h;G;/Log/s/\(FileLevel=\).*/\12/m;P;d' /etc/dmr2nxdn


                sudo /usr/local/sbin/dmr2nxdn.service restart > /dev/null
                sudo /usr/local/sbin/nxdngateweay.service restart  > /dev/null
test+=32
	fi
	if [ "$m7" = 'NXDN2DMR' ]; then
#		setdmr
		echo " Under Construction - Script Aborted"
exit
		echo "Starting NXDN2DMR Process" >> /home/pi-star/ActivateProfile.txt
		sudo sed -i '/^\[/h;G;/DMR Network/s/\(^Id=\).*/\1'"$m13"'/m;P;d' /etc/nxdn2dmr
		 sudo sed -i '/^\[/h;G;/Enabled/s/\(Enabled=\).*/\11/m;P;d' /etc/nxdn2dmr
		 sudo sed -i '/^\[/h;G;/Enabled/s/\(Enabled=\).*/\11/m;P;d' /etc/nxdngateway
		 sudo sed -i '/^\[/h;G;/NXDN/s/\(^Enable=\).*/\11/m;P;d' /etc/mmdvmhost.tmp
		 sudo sed -i '/^\[/h;G;/NXDN  Network/s/\(^Enable=\).*/\11/m;P;d' /etc/mmdvmhost.tmp

		echo "NXDN2DMR Enables Complete" >>  /home/pi-star/ActivateProfile.txt

		sudo sed -i '/^\[/h;G;/DMR Network/s/\(StartupDstId=\).*/\1'"$m9"'/m;P;d' /etc/nxdn2dmr
                sudo sed -i '/\[DMR Network\]/!b;n;cEnabled='"1"'' /etc/nxdn2dmr
		 sudo sed -i '/^\[/h;G;/Log/s/\(FileLevel=\).*/\12/m;P;d' /etc/nxdn2dmr

		echo "NXDN2DMR Mid Process" >> /home/pi-star/ActivateProfile.txt             
		 #sudo /usr/local/sbin/nxdngateweay.service restart  > /dev/null
		
		 echo " NXDN Enables Set" >> /home/pi-star/ActivateProfile.txt

		sudo sed -i '/^\[/h;G;/DMR Network/s/\(^Address=\).*/\1'"$m8"'/m;P;d' /etc/nxdn2dmr
		 sudo sed -i '/^\[/h;G;/DMR Network/s/\(^Port=\).*/\162031/m;P;d' /etc/nxdn2dmr
		 sudo sed -i '/^\[/h;G;/DMR Network/s/\(^Local=\).*/\162035/m;P;d' /etc/nxdn2dmr
		 sudo sed -i '/^\[/h;G;/DMR Network/s/\(^Password=\).*/\1passw0rd/m;P;d' /etc/nxdn2dmr

		echo "NXDN2DMR Process Complete" >> /home/pi-star/ActivateProfile.txt
		
                sudo /usr/local/sbin/nxdn2dmr.service restart 
                sudo /usr/local/sbin/nxdngateweay.service restart  
		echo "nxdn2dmr services started Complete" >> /home/pi-star/ActivateProfile.txt

	fi

	if [ "$m7" = 'YSF2DMR' ]; then
		 sudo sed -i '/^\[/h;G;/System Fusion/s/\(^Enable=\).*/\11/m;P;d' /etc/mmdvmhost.tmp
		 sudo sed -i '/^\[/h;G;/System Fusion Network/s/\(^Enable=\).*/\11/m;P;d' /etc/mmdvmhost.tmp
		 sudo sed -i '/^\[/h;G;/General/s/\(^Id=\).*/\1'"$m11"'/m;P;d' /etc/mmdvmhost.tmp
		 sudo sed -i '/^\[/h;G;/DMR/s/\(^Id=\).*/\1'"$m11"'/m;P;d' /etc/mmdvmhost.tmp

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
                sudo sed -i '/\[DMR Network\]/!b;n;cEnabled='"1"'' /etc/ysf2dmr
		 sudo sed -i '/^\[/h;G;/Info/s/\(RXFrequency=\).*/\1'"$m3"'/m;P;d' /etc/ysf2dmr
		 sudo sed -i '/^\[/h;G;/Info/s/\(TXFrequency=\).*/\1'"$m4"'/m;P;d' /etc/ysf2dmr
		 sudo sed -i '/^\[/h;G;/Log/s/\(FileLevel=\).*/\12/m;P;d' /etc/ysf2dmr
                sudo /usr/local/sbin/ysfgateway.service restart > /dev/null
                sudo /usr/local/sbin/ysf2dmr.service restart  > /dev/null
test+=32
	fi
	if [ "$m7" = 'YSF2NXDN' ]; then
		 sudo sed -i '/^\[/h;G;/Enabled/s/\(Enabled=\).*/\11/m;P;d' /etc/ysf2nxdn
		 sudo sed -i '/^\[/h;G;/YSF Network/s/\(EnableWiresX=\).*/\11/m;P;d' /etc/ysf2nxdn
		 sudo sed -i '/^\[/h;G;/NXDN Network/s/\(StartupDstId=\).*/\1'"$m9"'/m;P;d' /etc/ysf2nxdn
		 sudo sed -i '/^\[/h;G;/NXDN Network/s/\(^Address=\).*/\1'"$m8"'/m;P;d' /etc/ysf2nxdn
		 sudo sed -i '/^\[/h;G;/NXDN Network/s/\(^Port=\).*/\1'"$m10"'/m;P;d' /etc/ysf2nxdn
		 sudo sed -i '/^\[/h;G;/NXDN Network/s/\(Password=\).*/\1'"$m10"'/m;P;d' /etc/ysf2nxdn

		 sudo sed -i '/^\[/h;G;/NXDN Network/s/\(^Id=\).*/\1'"$m6"'/m;P;d' /etc/ysf2nxdn
		 sudo sed -i '/^\[/h;G;/NXDN Network/s/\(^Enabled=\).*/\11/m;P;d' /etc/ysf2nxdn
		 sudo sed -i '/^\[/h;G;/Log/s/\(FileLevel=\).*/\12/m;P;d' /etc/ysf2nxdn
setysfgateway
setysf
		 sudo sed -i '/^\[/h;G;/System Fusion/s/\(^Enable=\).*/\11/m;P;d' /etc/mmdvmhost.tmp
		 sudo sed -i '/^\[/h;G;/System Fusion Network/s/\(^Enable=\).*/\11/m;P;d' /etc/mmdvmhost.tmp
		 sudo sed -i '/^\[/h;G;/General/s/\(^Id=\).*/\1'"$m11"'/m;P;d' /etc/mmdvmhost.tmp
		 sudo sed -i '/^\[/h;G;/DMR/s/\(^Id=\).*/\1'"$m11"'/m;P;d' /etc/mmdvmhost.tmp
                sudo /usr/local/sbin/ysf2nxdn.service restart  > /dev/null
                sudo /usr/local/sbin/ysfgateway.service restart  > /dev/null
                sudo /usr/local/sbin/nxdngateway.service restart > /dev/null

		echo "YSF2NXDN Services Started"
test+=32
	fi

	if [ "$m7" = 'YSF2P25' ]; then

		 sudo sed -i '/^\[/h;G;/Enabled/s/\(Enabled=\).*/\11/m;P;d' /etc/ysf2p25
		 sudo sed -i '/^\[/h;G;/YSF Network/s/\(EnableWiresX=\).*/\11/m;P;d' /etc/ysf2p25
		 sudo sed -i '/^\[/h;G;/P25 Network/s/\(StartupDstId=\).*/\1'"$m9"'/m;P;d' /etc/ysf2p25
		 sudo sed -i '/^\[/h;G;/P25 Network/s/\(^Address=\).*/\1'"$m8"'/m;P;d' /etc/ysf2p25
		 sudo sed -i '/^\[/h;G;/P25 Network/s/\(^Port=\).*/\1'"$m10"'/m;P;d' /etc/ysf2p25
		 sudo sed -i '/^\[/h;G;/P25 Network/s/\(^Id=\).*/\1'"$m6"'/m;P;d' /etc/ysf2p25
		 sudo sed -i '/^\[/h;G;/P25 Network/s/\(Enabled=\).*/\11/m;P;d' /etc/ysf2p25
		 sudo sed -i '/^\[/h;G;/P25 Network/s/\(Enabled=\).*/\11/m;P;d' /etc/ysf2p25
		 sudo sed -i '/^\[/h;G;/P25 Network/s/\(Password=\).*/\1'"$m12"'/m;P;d' /etc/ysf2p25
		 sudo sed -i '/^\[/h;G;/Log/s/\(FileLevel=\).*/\12/m;P;d' /etc/ysf2p25
setysfgateway

                sudo /usr/local/sbin/ysfgateway.service restart > /dev/null
                sudo /usr/local/sbin/ysf2p25.service restart  > /dev/null
                sudo /usr/local/sbin/p25gateway.service restart  > /dev/null
		echo "YSF2P25 Services Started"
test+=32
    
	fi



	if [ "$m7" = 'TGIF' ]; then 
		setdmr
             	sudo sed -i '/^\[/h;G;/DMR Network/s/\(^Address=\).*/\1'"$m8"'/m;P;d' /etc/mmdvmhost.tmp
		echo "Processing Profile = $pnum  Mode = $m7  Finished"  >> /home/pi-star/ActivateProfile.txt
	fi 
fi

echo "Processing Profile = $pnum  Mode = $m7  Ready for Reboot" >> /home/pi-star/ActivateProfile.txt

#echo "Profile $pnum - Loaded  - $m7"
systemctl stop mmdvmhost
systemctl stop mmdvmhost.timer
sudo rm /etc/mmdvmhost
sudo mv -f /etc/mmdvmhost.tmp /etc/mmdvmhost

if [  "$?" == 0 ]; then
  echo "Resrore mmdvmhost OK!"
else
  echo "Restore mmdvmhost FAILED!"
fi

systemctl start mmdvmhost
systemctl start mmdvmhost.timer

ysfgateway.service restart
ysf2dmr.service restart 
dmrgateway.service restart
echo "Profile Script Completed Processing Test=$test"
echo "Profile Script Completed Processing Test=$test"  >> /home/pi-star/ActivateProfile.txt

#startprocesses
#reboot

