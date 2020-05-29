#!/bin/bash
############################################################
#  Activate  DMRGateway                                    #
#  VE3RD                                      2020/05/29   #
############################################################
set -o errexit
set -o pipefail
sudo mount -o remount,rw /
sudo cp /etc/mmdvmhost /etc/mmdvmhost.tmp

function ActivateDMRGateway
{
                         sudo sed -i '/^\[/h;G;/DMR/s/\(^Enable=\).*/\11/m;P;d' /etc/mmdvmhost
                         sudo sed -i '/^\[/h;G;/DMR Network/s/\(^Enable=\).*/\11/m;P;d' /etc/mmdvmhost
                         sudo sed -i '/^\[/h;G;/DMR Network/s/\(^Address=\).*/\1127.0.0.1/m;P;d' /etc/mmdvmhost
		         sudo sed -i '/^\[/h;G;/DMR Network/s/\(^Port=\).*/\162031/m;P;d' /etc/mmdvmhost
			sudo dmrgateway.service restart
}
function ActivateTGIF
{
                         sudo sed -i '/^\[/h;G;/DMR/s/\(^Enable=\).*/\11/m;P;d'  /etc/mmdvmhost
                         sudo sed -i '/^\[/h;G;/DMR Network/s/\(^Enable=\).*/\11/m;P;d'  /etc/mmdvmhost
                         sudo sed -i '/^\[/h;G;/DMR Network/s/\(^Address=\).*/\1tgif.network/m;P;d'  /etc/mmdvmhost
		         sudo sed -i '/^\[/h;G;/DMR Network/s/\(Port=\).*/\162031/m;P;d'  /etc/mmdvmhost
		         sudo sed -i '/^\[/h;G;/DMR Network/s/\(ModeHang=\).*/\110/m;P;d'  /etc/mmdvmhost
			sudo dmrgateway.service stop
}



systemctl stop mmdvmhost
systemctl stop mmdvmhost.timer

if [ "$1" == "1" ]; then
	ActivateDMRGateway
else
	ActivateTGIF
fi

if [  "$?" == 0 ]; then
  echo "Resrore mmdvmhost OK!"
else
  echo "Restore mmdvmhost FAILED!"
fi

#cp /etc/mmdvmhost.tmp /etc/mmdvmhost

systemctl start mmdvmhost
systemctl start mmdvmhost.timer

if [ "$1" == "1" ]; then
dmrgateway.service restart
fi
echo "Profile Script Completed Processing Test=$test"
echo "Profile Script Completed Processing Test=$test"  >> /home/pi-star/ActivateProfile.txt

#startprocesses
#reboot

