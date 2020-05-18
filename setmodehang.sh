#!/bin/bash
############################################################
#  Set or Modem Hang                                       #
#  VE3RD                                      2019/10/28   #
############################################################
set -o errexit
set -o pipefail
sudo mount -o remount,rw /
#echo "Set ModeHang"

if [ -z "$1" ] || [ -z "$2" ]; then
        exit
fi
        if [ "$1" = "21A" ]; then 
		 sudo sed -i '/^\[/h;G;/DMR/s/\(ModeHang=\).*/\1'"$2"'/m;P;d'  /etc/mmdvmhost      
	fi
        if [ "$1" = "21B" ]; then 
	 	sudo sed -i '/^\[/h;G;/DMR Network/s/\(ModeHang=\).*/\1'"$2"'/m;P;d'  /etc/mmdvmhost      
        fi
####

        if [ "$1" = "22A" ]; then 
		 sudo sed -i '/^\[/h;G;/NXDN/s/\(ModeHang=\).*/\1'"$2"'/m;P;d'  /etc/mmdvmhost  
	fi
        if [ "$1" = "22B" ]; then 
		 sudo sed -i '/^\[/h;G;/NXDN Network/s/\(ModeHang=\).*/\1'"$2"'/m;P;d'  /etc/mmdvmhost  
        fi
        if [ "$1" = "23A" ]; then 
		 sudo sed -i '/^\[/h;G;/System Fusion/s/\(ModeHang=\).*/\1'"$2"'/m;P;d'  /etc/mmdvmhost     
	fi
        if [ "$1" = "23B" ]; then 
		 sudo sed -i '/^\[/h;G;/System Fusion Network/s/\(ModeHang=\).*/\1'"$2"'/m;P;d'  /etc/mmdvmhost     
        fi
        if [ "$1" = "24A" ]; then 
		 sudo sed -i '/^\[/h;G;/P25/s/\(ModeHang=\).*/\1'"$2"'/m;P;d'  /etc/mmdvmhost      
	fi
        if [ "$1" = "24B" ]; then 
		 sudo sed -i '/^\[/h;G;/P25 Network/s/\(ModeHang=\).*/\1'"$2"'/m;P;d'  /etc/mmdvmhost      
        fi
        if [ "$1" = "25A" ]; then 
		 sudo sed -i '/^\[/h;G;/D-Star/s/\(ModeHang=\).*/\1'"$2"'/m;P;d'  /etc/mmdvmhost     
	fi
        if [ "$1" = "25B" ]; then 
		 sudo sed -i '/^\[/h;G;/D-Star Network/s/\(ModeHang=\).*/\1'"$2"'/m;P;d'  /etc/mmdvmhost     
        fi
sudo mount -o remount,ro /
