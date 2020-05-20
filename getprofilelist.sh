#!/bin/bash
############################################################
#  Get  Profile from profiles.txt                          #
#  Returns a multi string   Separated                      #
#                                                          #
#                                                          #
#  VE3RD                                     2019-11-17    #
############################################################
set -o errexit
set -o pipefail
dirn=/home/pi-star/SmartPhone/profiles.txt


		m1=$(sed -nr "/^\[Profile 1\]/ { :l /^Name[ ]*=/ { s/.*=[ ]*//; p; q;}; n; b l;}" $dirn)
		m2=$(sed -nr "/^\[Profile 2\]/ { :l /^Name[ ]*=/ { s/.*=[ ]*//; p; q;}; n; b l;}" $dirn)
		m3=$(sed -nr "/^\[Profile 3\]/ { :l /^Name[ ]*=/ { s/.*=[ ]*//; p; q;}; n; b l;}" $dirn)
		m4=$(sed -nr "/^\[Profile 4\]/ { :l /^Name[ ]*=/ { s/.*=[ ]*//; p; q;}; n; b l;}" $dirn)
		m5=$(sed -nr "/^\[Profile 5\]/ { :l /^Name[ ]*=/ { s/.*=[ ]*//; p; q;}; n; b l;}" $dirn)
		m6=$(sed -nr "/^\[Profile 6\]/ { :l /^Name[ ]*=/ { s/.*=[ ]*//; p; q;}; n; b l;}" $dirn)
		m7=$(sed -nr "/^\[Profile 7\]/ { :l /^Name[ ]*=/ { s/.*=[ ]*//; p; q;}; n; b l;}" $dirn)
		m8=$(sed -nr "/^\[Profile 8\]/ { :l /^Name[ ]*=/ { s/.*=[ ]*//; p; q;}; n; b l;}" $dirn)
		m9=$(sed -nr "/^\[Profile 9\]/ { :l /^Name[ ]*=/ { s/.*=[ ]*//; p; q;}; n; b l;}" $dirn)
		m10=$(sed -nr "/^\[Profile 10\]/ { :l /^Name[ ]*=/ { s/.*=[ ]*//; p; q;}; n; b l;}" $dirn)


                printf "%s \n%s \n%s \n%s \n%s \n%s \n%s \n%s \n%s \n%s\n" "$m1" "$m2" "$m3" "$m4" "$m5" "$m6" "$m7" "$m8" "$m9" "$m10" 
       #        	printf ($m1\n$m2\n$m3 $m4 $m5 $m6 $m7 $m8 $m9 $m10)
#		echo "$mt"
	
