#!/bin/ksh
# Creatin Date : May 01, 2015
# Author : Raghu Sodha
# Description : This script lists IP addresses against a list of DNS names. Script is useful and saves your time when you want to find IP addresses for a bunch of servers.

# Usage : ./main.sh
# Exit Codes :

# Use your choice of editor like notepad++ to get hostlist in space saperated form
host_list="host1 host2 host3"

for host in $host_list
do
ip_address=`nslookup $host | grep Address | grep -v \# | awk -F\: '{print $2}'`
echo $host $ip_address
done
