#!/bin/bash
############################################################
#  Change Set XLX Reflector and Module                     #
#                                                          #
#  					                   #
#  Also Reset DMRGateway	                           #
#  KF6S                                        09-14-2019  #
############################################################
set -o errexit
set -o pipefail

# Param 1 is Reflector
# Param 2 is Module

E="$1"
R="$2"
N="$3"
if [ -z "$3" ]; then
        exit
else

	sudo sed -i '/^\[/h;G;/\[XLX Network/s/\(Enabled=\).*/\1'"$1"'/m;P;d' /etc/dmrgateway
	sudo sed -i '/^\[/h;G;/\[XLX Network/s/\(Startup=\).*/\1'"$2"'/m;P;d' /etc/dmrgateway
	sudo sed -i '/^\[/h;G;/\[XLX Network/s/\(Module=\).*/\1'"$3"'/m;P;d' /etc/dmrgateway

fi;
