#!/bin/bash
### Copyright 1999-2023. Plesk International GmbH.

##################################################
# This script extracts SEO-safe 301 redirect's status for all domains to the file redirect.csv, which can be imported to the new server to restore these values.
# Version      : 1.0
#########
MYSQL_PWD=`cat /etc/psa/.psa.shadow` mysql -Ns -uadmin -D psa -e "select concat(domains.id,',', domains.name) from domains" > domains_list;
echo -n > redirect.csv
for i in `cat domains_list`
do
        domain_name=`echo $i | cut -d ',' -f2`
        redirect=`plesk bin site --info $domain_name | grep 'Permanent SEO-safe 301 redirect from HTTP to HTTPS:'`
        echo $domain_name','"${redirect#*:}" | tee -a redirect.csv
done
