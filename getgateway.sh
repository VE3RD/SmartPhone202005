#!/bin/bash
############################################################
#  Get Gateway Network Status  from /etc/dmrgateway        #
#  $1 1-6 Select Mode to get status of                     #
#                                                          #
#  Returns a String                                        #
#                                                          #
#  VE3RD                                     2020-05-29    #
############################################################
set -o errexit
set -o pipefail

  n0=$(sed -nr "/^\[DMR Network\]/ { :l /^Address[ ]*=/ { s/.*=[ ]*//; p; q;}; n; b l;}" /etc/mmdvmhost)
if [ "$n0" == 127.0.0.1 ]; then
# Using DMRGateway
 n0="1"
else
# DMRGateway is NOT in use
 n0="0"
fi

  n1=$(sed -nr "/^\[DMR Network 1\]/ { :l /^Enabled[ ]*=/ { s/.*=[ ]*//; p; q;}; n; b l;}" /etc/dmrgateway)
  n2=$(sed -nr "/^\[DMR Network 2\]/ { :l /^Enabled[ ]*=/ { s/.*=[ ]*//; p; q;}; n; b l;}" /etc/dmrgateway)
  n3=$(sed -nr "/^\[DMR Network 3\]/ { :l /^Enabled[ ]*=/ { s/.*=[ ]*//; p; q;}; n; b l;}" /etc/dmrgateway)
  n4=$(sed -nr "/^\[DMR Network 4\]/ { :l /^Enabled[ ]*=/ { s/.*=[ ]*//; p; q;}; n; b l;}" /etc/dmrgateway)
  n5=$(sed -nr "/^\[DMR Network 5\]/ { :l /^Enabled[ ]*=/ { s/.*=[ ]*//; p; q;}; n; b l;}" /etc/dmrgateway)
  n6=$(sed -nr "/^\[DMR Network 6\]/ { :l /^Enabled[ ]*=/ { s/.*=[ ]*//; p; q;}; n; b l;}" /etc/dmrgateway)
 
  n7=$(sed -nr "/^\[DMR Network 1\]/ { :l /^Name[ ]*=/ { s/.*=[ ]*//; p; q;}; n; b l;}" /etc/dmrgateway)
  n8=$(sed -nr "/^\[DMR Network 2\]/ { :l /^Name[ ]*=/ { s/.*=[ ]*//; p; q;}; n; b l;}" /etc/dmrgateway)
  n9=$(sed -nr "/^\[DMR Network 3\]/ { :l /^Name[ ]*=/ { s/.*=[ ]*//; p; q;}; n; b l;}" /etc/dmrgateway)
  n10=$(sed -nr "/^\[DMR Network 4\]/ { :l /^Name[ ]*=/ { s/.*=[ ]*//; p; q;}; n; b l;}" /etc/dmrgateway)
  n11=$(sed -nr "/^\[DMR Network 5\]/ { :l /^Name[ ]*=/ { s/.*=[ ]*//; p; q;}; n; b l;}" /etc/dmrgateway)
  n12=$(sed -nr "/^\[DMR Network 6\]/ { :l /^Name[ ]*=/ { s/.*=[ ]*//; p; q;}; n; b l;}" /etc/dmrgateway)

  n13=$(sed -nr "/^\[DMR Network 1\]/ { :l /^Address[ ]*=/ { s/.*=[ ]*//; p; q;}; n; b l;}" /etc/dmrgateway)
  n14=$(sed -nr "/^\[DMR Network 2\]/ { :l /^Address[ ]*=/ { s/.*=[ ]*//; p; q;}; n; b l;}" /etc/dmrgateway)
  n15=$(sed -nr "/^\[DMR Network 3\]/ { :l /^Address[ ]*=/ { s/.*=[ ]*//; p; q;}; n; b l;}" /etc/dmrgateway)
  n16=$(sed -nr "/^\[DMR Network 4\]/ { :l /^Address[ ]*=/ { s/.*=[ ]*//; p; q;}; n; b l;}" /etc/dmrgateway)
  n17=$(sed -nr "/^\[DMR Network 5\]/ { :l /^Address[ ]*=/ { s/.*=[ ]*//; p; q;}; n; b l;}" /etc/dmrgateway)
  n18=$(sed -nr "/^\[DMR Network 6\]/ { :l /^Address[ ]*=/ { s/.*=[ ]*//; p; q;}; n; b l;}" /etc/dmrgateway)

  printf "$n0\n$n1\n$n2\n$n3\n$n4\n$n5\n$n6\n$n7\n$n8\n$n9\n$n10\n$n11\n$n12\n$n13\n$n14\n$n15\n$n16\n$n17\n$n18\n$"



