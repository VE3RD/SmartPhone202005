#!/bin/bash
############################################################
#  Get  ModeHang from /etc/dmrgateway                      #
#  $1 1-6 Select Mode to get status of                     #
#                                                          #
#  Returns a String                                        #
#                                                          #
#  VE3RD                                     2019-11-14    #
############################################################
set -o errexit
set -o pipefail

#declare -i m1
#declare -i m2
#declare -i m3
#declare -i m4
#declare -i m5
#declare -i m6
#declare -i mt
if [ -z "$1" ]; then
        exit
        else
        if [ "$1" = 21 ]; then
		m1=$(sed -nr "/^\[DMR\]/ { :l /^ModeHang[ ]*=/ { s/.*=[ ]*//; p; q;}; n; b l;}" /etc/mmdvmhost)
		m2=$(sed -nr "/^\[NXDN\]/ { :l /^ModeHang[ ]*=/ { s/.*=[ ]*//; p; q;}; n; b l;}" /etc/mmdvmhost)
		m3=$(sed -nr "/^\[System Fusion\]/ { :l /^ModeHang[ ]*=/ { s/.*=[ ]*//; p; q;}; n; b l;}" /etc/mmdvmhost)
		m4=$(sed -nr "/^\[P25\]/ { :l /^ModeHang[ ]*=/ { s/.*=[ ]*//; p; q;}; n; b l;}" /etc/mmdvmhost)
		m5=$(sed -nr "/^\[D-Star\]/ { :l /^ModeHang[ ]*=/ { s/.*=[ ]*//; p; q;}; n; b l;}" /etc/mmdvmhost)
		mt21="$m1|$m2|$m3|$m4|$m5"
		echo "$mt21"
	fi
        if [ "$1" = 22 ]; then
		m11=$(sed -nr "/^\[DMR Network\]/ { :l /^ModeHang[ ]*=/ { s/.*=[ ]*//; p; q;}; n; b l;}" /etc/mmdvmhost)
		m12=$(sed -nr "/^\[NXDN Network\]/ { :l /^ModeHang[ ]*=/ { s/.*=[ ]*//; p; q;}; n; b l;}" /etc/mmdvmhost)
		m13=$(sed -nr "/^\[System Fusion Network\]/ { :l /^ModeHang[ ]*=/ { s/.*=[ ]*//; p; q;}; n; b l;}" /etc/mmdvmhost)
		m14=$(sed -nr "/^\[P25 Network\]/ { :l /^ModeHang[ ]*=/ { s/.*=[ ]*//; p; q;}; n; b l;}" /etc/mmdvmhost)
		m15=$(sed -nr "/^\[D-Star Network\]/ { :l /^ModeHang[ ]*=/ { s/.*=[ ]*//; p; q;}; n; b l;}" /etc/mmdvmhost)
		mt22="$m11|$m12|$m13|$m14|$m15"
		echo "$mt22"
	fi

	if [ "$1" = 30 ]; then
                m1=$(sed -nr "/^\[D-Star\]/ { :l /^ModeHang[ ]*=/ { s/.*=[ ]*//; p; q;}; n; b l;}" /etc/mmdvmhost)
                m2=$(sed -nr "/^\[D-Star Network\]/ { :l /^ModeHang[ ]*=/ { s/.*=[ ]*//; p; q;}; n; b l;}" /etc/mmdvmhost)

                m3=$(sed -nr "/^\[DMR\]/ { :l /^ModeHang[ ]*=/ { s/.*=[ ]*//; p; q;}; n; b l;}" /etc/mmdvmhost)
                m4=$(sed -nr "/^\[DMR Network\]/ { :l /^ModeHang[ ]*=/ { s/.*=[ ]*//; p; q;}; n; b l;}" /etc/mmdvmhost)

                m5=$(sed -nr "/^\[System Fusion\]/ { :l /^ModeHang[ ]*=/ { s/.*=[ ]*//; p; q;}; n; b l;}" /etc/mmdvmhost)
                m6=$(sed -nr "/^\[System Fusion Network\]/ { :l /^ModeHang[ ]*=/ { s/.*=[ ]*//; p; q;}; n; b l;}" /etc/mmdvmhost)

                m7=$(sed -nr "/^\[NXDN\]/ { :l /^ModeHang[ ]*=/ { s/.*=[ ]*//; p; q;}; n; b l;}" /etc/mmdvmhost)
                m8=$(sed -nr "/^\[NXDN Network\]/ { :l /^ModeHang[ ]*=/ { s/.*=[ ]*//; p; q;}; n; b l;}" /etc/mmdvmhost)

                m9=$(sed -nr "/^\[P25\]/ { :l /^ModeHang[ ]*=/ { s/.*=[ ]*//; p; q;}; n; b l;}" /etc/mmdvmhost)
                m10=$(sed -nr "/^\[P25 Network\]/ { :l /^ModeHang[ ]*=/ { s/.*=[ ]*//; p; q;}; n; b l;}" /etc/mmdvmhost)


                mt30=$m1$'\n'
		mt30+=$m2$'\n'
		mt30+=$m3$'\n'
		mt30+=$m4$'\n'
		mt30+=$m5$'\n'
		mt30+=$m6$'\n'
		mt30+=$m7$'\n'
		mt30+=$m8$'\n'
		mt30+=$m9$'\n'
		mt30+=$m10$'\n'

                echo "$mt30"
	fi
fi;

