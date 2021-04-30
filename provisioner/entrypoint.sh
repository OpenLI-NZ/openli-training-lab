#!/bin/bash
set -e

#IPADDR=`ip a | grep inet | grep eth0 | awk '{print $2}' | cut -d '/' -f 1`
#sed -i "s/<PROVIP>/${IPADDR}/" /etc/openli/provisioner-config.yaml

service rsyslog restart
#service openli-provisioner start

while true; do
    sleep 100
done
