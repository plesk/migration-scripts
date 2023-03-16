#!/bin/bash
### Copyright 1999-2023. Plesk International GmbH.

###############################################################################
# This script creates subscriptions with domain name, system user login and password specified in a cred.csv file
# Version      : 1.1
#########
echo Please enter the IP address for deploying subscriptions and press Enter.
read IPADDRESS
echo 'Loading credentials list: '
while read LINE; do
        SUBSCRIPTION=`echo $LINE | cut -d ' ' -f1`
        SYSUSER_LOGIN=`echo $LINE | cut -d ' ' -f2`
        SYSUSER_PASSWORD=`echo $LINE | cut -d ' ' -f3`
        echo 'Deploy Subscription: ' $SUBSCRIPTION
        plesk bin subscription --create $SUBSCRIPTION -owner 'admin' -service-plan 'Default Domain' -login $SYSUSER_LOGIN -passwd $SYSUSER_PASSWORD -ip $IPADDRESS -www-root 'public'
done < cred.csv
