#!/bin/bash

#My first bash script

#using hostname displays Fully-qulified domain name

hostname=$(hostname -f)

osname=$(hostnamectl | grep -A 0 'Operating System' |cut -d ':' -f 2 | cut -d ' ' -f 2)

Version=$( hostnamectl | grep -A 0 'Kernel' |cut -d ':' -f 2 | cut -d ' ' -f 2,3 | cut -d '.' -f 1)

defaultIP=$(ip route | grep -A 0 'default' | cut -d ' ' -f 3)

freespace=$(df -h / | awk 'NR==2 {print $4}')

cat <<EOF
Report for myvm
===============
FQDN: $hostname
Operating System name and version: $osname/$Version
IP Address: $defaultIP 
Root Filesystem Free Space: $freespace
===============
EOF
