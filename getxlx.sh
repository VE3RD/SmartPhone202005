#!/bin/bash
############################################################
#  Get XLX Info  from /etc/dmrgateway                      #
#                                                          #
#  Returns a String                                        #
#                                                          #
#  VE3RD                                     2020-05-29    #
############################################################
set -o errexit
set -o pipefail

  n1=$(sed -nr "/^\[XLX Network\]/ { :l /^Enabled[ ]*=/ { s/.*=[ ]*//; p; q;}; n; b l;}" /etc/dmrgateway)
  n2=$(sed -nr "/^\[XLX Network\]/ { :l /^Startup[ ]*=/ { s/.*=[ ]*//; p; q;}; n; b l;}" /etc/dmrgateway)
  n3=$(sed -nr "/^\[XLX Network\]/ { :l /^Module[ ]*=/ { s/.*=[ ]*//; p; q;}; n; b l;}" /etc/dmrgateway)


  echo "$n1 $n2 n3"



