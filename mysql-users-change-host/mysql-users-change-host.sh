#!/bin/bash

# VARS
export PATH=$PATH:/usr/bin/:/bin/:/sbin/:/usr/sbin
port=3306
ip=127.0.0.1
un=admin

# Functions
function mQuery(){
	mysql -u$un -p`cat /etc/psa/.psa.shadow` -h $ip -P $port -BNe "$@"
}

# Body

dbUsers=$(mQuery "select User from mysql.user where User not in ('admin','apsc','root','roundcube','horde','phpmyadmin')")

while read -r user ; do
	dbUser=$(echo $line | sed 's/;.*//g')
	mQuery "update mysql.user SET Host = '$ip' where User='$user'"
	mQuery "flush privileges"
done <<< "$dbUsers"

exit 0
