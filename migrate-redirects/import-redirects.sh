#!/bin/bash
### Copyright 1999-2023. Plesk International GmbH.

##################################################
# This script imports 301 redirect statuses for all domains from the file redirect.csv, which have been previously exported by export-redirects.sh on the source server.
# Version      : 1.0
#########
for i in `cat redirect.csv`
do
        domain_name=`echo $i | cut -d ',' -f1`
                redirect_state=`echo $i | cut -d ',' -f2`
                if [[ "$redirect_state" == "On" ]]; then
                        state='true'
                elif [[ "$redirect_state" == "Off" ]]; then
                        state='false'
                else
                        echo "Error of type redirect"
                fi
        redirect=`plesk bin site --update $domain_name -ssl-redirect $state`
        echo $domain_name 'UPDATED!'
done
