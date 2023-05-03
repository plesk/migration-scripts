#!/bin/bash
### Copyright 1999-2023. Plesk International GmbH.
### Exporting and importing the PHP disable_functions values on domains

MYSQL_PASSWORD=`cat /etc/psa/.psa.shadow`
PATH=/sbin:/bin:/usr/sbin:/usr/bin


function mysql_exec(){
    MYSQL_PWD=$MYSQL_PASSWORD mysql -Ns -uadmin -D psa -e "$@"
}

function export(){
rm -rf *disable_functions.csv
touch no_disable_functions.csv
touch disable_functions.csv

domains=`mysql_exec "select name from domains d
join hosting h
where d.id=h.dom_id
and d.htype='vrt_hst';"`

while read domain
    do
        # Does domain use disable_functions?
        disableFunctions=$(mysql_exec "select phpp.value from PhpSettingsParameters phpp join domains d join dom_param dp where d.id=dp.dom_id and dp.param='phpSettingsId' and dp.val=phpp.id and phpp.name='disable_functions' and d.name='$domain'")
        if [[ ! -z $disableFunctions ]] ; then
            printf "$domain : $disableFunctions\n" | tee -a disable_functions.csv
        fi
done <<< "$domains"
}

function import(){

disableFunctions=$(cat disable_functions.csv)

while read -r line ; do
    domain=$(echo $line | awk {'print $1'})
    dfParams=$(echo $line | sed 's/.*: //g')
    #echo "Domain = $domain & params = $dfParams"
    #mysql_exec "update PhpSettingsParameters phpp join domains d join dom_param dp set phpp.value='$dfParams' where d.id=dp.dom_id and dp.param='phpSettingsId' and dp.val=phpp.id and phpp.name='disable_functions' and d.name='$domain';"
    printf "disable_functions = $dfParams" > phpconf.tmp
    plesk bin site --update-php-settings $domain -settings phpconf.tmp
done <<< "$disableFunctions"
}


case $1 in
--export)
export
;;
--import)
import
;;
*)
echo "Argument required. It should be --export or --import" && exit 0
;;
esac


exit 0
