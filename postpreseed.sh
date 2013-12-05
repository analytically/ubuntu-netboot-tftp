#!/bin/bash

# fetch the hostnames file
tftp 172.16.0.1 -c get hostnames

# get the MAC address
mac=$(/sbin/ifconfig | grep 'eth0\|p2p1\|em1\|igb0' | tr -s ' ' | cut -d ' ' -f5)

# get the correct hostname for this MAC address
hostname=$(cat hostnames | grep $mac | cut -d"-" -f2)

# set the hostname
echo $hostname | tee /etc/hostname
hostname -b $hostname
echo "127.0.0.1         localhost $hostname" > /etc/hosts

rm hostnames