#!/bin/bash

#My first bash script

#using hostname displays Fully-qulified domain name
echo "FQDN : $(hostname -f)"

#using hostnamectl displyas full information of host computer.
echo -e "Host Information :\n $(hostnamectl)"

#using hostname command with extantion I finding all the ip adress on the host computer
echo -e "IP Addresses: \n $(hostname -I)"

#using df commang with option h displaying the amount of spaceused by the root filesystem

echo -e "Root FileSystem Status: \n $(df -h /)"
