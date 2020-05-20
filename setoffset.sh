#!/bin/bash
############################################################
#  Set MMDVMHost Off                                       #
#  VE3RD                                      2020-05-20   #
############################################################
set -o errexit
set -o pipefail
sudo mount -o remount,rw /
if [ -f "$1" ]; then exit

# if length <> 9 exit

 sudo sed -i '/^\[/h;G;/Modem/s/\($1=\).*/\1'"$2"'/m;P;d' /etc/mmdvmhost.tmp
 #sudo sed -i '/^\[/h;G;/Modem/s/\(RXOffset=\).*/\1'"$2"'/m;P;d' /etc/mmdvmhost.tmp
   



