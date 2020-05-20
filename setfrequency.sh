#!/bin/bash
############################################################
#  Set MMDVMHost Frequency                                 #
#  VE3RD                                      2020-05-20   #
############################################################
set -o errexit
set -o pipefail
sudo mount -o remount,rw /
if [ -f "$1" ]; then exit

# if length <> 9 exit

 sudo sed -i '/^\[/h;G;/Info/s/\($1=\).*/\1'"$2"'/m;P;d' /etc/mmdvmhost.tmp
 #sudo sed -i '/^\[/h;G;/Info/s/\(TXFrequency=\).*/\1'"$m4"'/m;P;d' /etc/mmdvmhost.tmp
   



