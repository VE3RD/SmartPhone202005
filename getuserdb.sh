#!/bin/bash
############################################################
#  Set MMDVMHost Off                                       #
#  VE3RD                                      2020-05-20   #
############################################################
set -o errexit
set -o pipefail
sudo mount -o remount,rw /
rm user.csv
wget https://database.radioid.net/static/user.csv
