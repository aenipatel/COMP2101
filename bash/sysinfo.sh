#!/bin/bash

#Lab 2 updated sysinfo.sh

#using hostname and storing the result in to the variable name hostname

hostname=$(hostname -f)

#entring value in to variable name osnmae using hostnamectl, grep and cut command

osname=$(hostnamectl | grep -A 0 'Operating System' |cut -d ':' -f 2 | cut -d ' ' -f 2)

#entring value in to variable name Version using hostnamectl, grep and cut command

Version=$( hostnamectl | grep -A 0 'Kernel' |cut -d ':' -f 2 | cut -d ' ' -f 2,3 | cut -d '.' -f 1)

#entring value in to variable name defaultIP  using ip route, grep and cut command

defaultIP=$(ip route | grep -A 0 'default' | cut -d ' ' -f 3)

#finding the empty spavce in the root directory using df command

freespace=$(df -h / | awk 'NR==2 {print $4}')


#Final Output using cat and EOF command as per requirements

cat <<EOF
Report for myvm
===============
FQDN: $hostname
Operating System name and version: $osname/$Version
IP Address: $defaultIP 
Root Filesystem Free Space: $freespace
===============
EOF
