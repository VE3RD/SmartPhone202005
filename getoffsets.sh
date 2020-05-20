#!/bin/bash

  m3=$(sed -nr "/^\[Modem\]/ { :l /^RXOffset[ ]*=/ { s/.*=[ ]*//; p; q;}; n; b l;}" /etc/mmdvmhost)
  m4=$(sed -nr "/^\[Modem\]/ { :l /^TXOffset[ ]*=/ { s/.*=[ ]*//; p; q;}; n; b l;}" /etc/mmdvmhost)
 
printf "%s \n%s \n" $m3 $m4



