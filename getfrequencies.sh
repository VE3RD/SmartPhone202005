#!/bin/bash

  m3=$(sed -nr "/^\[General\]/ { :l /^RXFrequency[ ]*=/ { s/.*=[ ]*//; p; q;}; n; b l;}" /etc/mmdvmhost)
  m4=$(sed -nr "/^\[General\]/ { :l /^TXFrequency[ ]*=/ { s/.*=[ ]*//; p; q;}; n; b l;}" /etc/mmdvmhost)
 
printf "$m3\n$m4\n"



