#!/bin/bash
### Copyright 1999-2023. Plesk International GmbH.
### Manage remote databases

export PATH=$PATH:/usr/bin/:/bin/:/sbin/:/usr/sbin
DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" >/dev/null 2>&1 && pwd )"
PORT=3306
# Sanity checks and args acquisition

if [ -z $1 ] ; then
	read -p "Enter target IP Address: " ip
	if [ -z $ip ] ; then
		echo "IP Address isn't specified. Exiting ... " && help && exit 0
	fi
else
	ip=$1
fi

if [ ! -f "$DIR/passwd.txt" ] ; then
	echo "$DIR/passwd.txt is missing. Please, create it. See --help argument for additional details."
fi

un=$(cat $DIR/passwd.txt | awk {'print $1'})
pw=$(cat $DIR/passwd.txt | awk {'print $3'})
if [[ -z "$un" || -z "$pw" ]] ; then
	echo -e "Password or username is missing. Make sure passwd.txt exists and has valid content, e.g. \njdoe ; password123" && exit 0
fi

# /Sanity checks

# Functions
function mQuery(){
	mysql -u$un -p$pw -h $ip -P $PORT -BNe "$@"
}

function mRestore(){
	mysql -u$un -p$pw -h $ip -P $PORT $@
}

function mDump(){
	dbList=$(mQuery "show databases" | egrep -vE '(information_schema|mysql|performance_schema)')
	while read -r db ; do
	echo -e "Backing up DB: $db" >&2
	mysqldump -u$un -p$pw -h $ip $db > $DIR/$db.sql
	if [[ `tail -n1 $DIR/$db.sql` == *"Dump completed"* ]]; then
		echo -e "Dump of $db validation \\e[32msuccessful\\e[m"
	else
		echo -e "Dump of $db validation \\e[31mfailed\\e[m. Re-run dump operation again or dump $db manually."
	fi
	done <<< "$dbList"
}

function dropUsers(){
	dbUsers=$(mQuery "select user,host from mysql.user" | awk '{print "\047"$1"\047" "@" "\047"$2"\047"}' | grep -v "$un")
	#echo "$dbUsers" && exit 0
	while read -r user ; do
		mQuery "drop user $user;"
	done <<< "$dbUsers"
}

function dropDatabases(){
	dbList=$(mQuery "show databases" | egrep -vE '(information_schema|mysql|performance_schema)')
	while read -r db ; do
		echo "Dropping $db from $ip ..."
		mQuery "drop database $db"
	done <<< "$dbList"
}


function uploadDatabases(){
	dbList=$(ls $DIR/*sql)
	while read -r db ; do
		dbName=$(basename "$db" | sed 's/.sql//g')
		echo "Restoring $db on $ip ..."
		mQuery "create database if not exists $dbName"
		mRestore $dbName < $db
	done <<< "$dbList"
}

help() {
    cat <<HELP
The script is designed to:
- dump databases from a remote MySQL server to a local dir(where the script being run from)
- drop databases and users from a remote MySQL server.
- restore database dumps from the directory where the script is located onto a remote MySQL server

Usage: 
Make sure the 'passwd.txt' file exists in $DIR with the remote MySQL username and password
with a single delimeter. For example:
jdoe ; password123

Call the script using ip as a first argument and action as a second argument. Available actions are:
--dump        dumps all databases from a remote server to the script's local dir
--drop-dbs    deletes all databases(except information_schema, mysql and performance_schema) from a remote server 
--drop-users  deletes all users from a remote MySQL server(except the one being used by script)
--restore-dbs uploads databases from $DIR to a remote MySQL server
HELP
}

# /Functions



case $2 in
	--dump)
	mDump
	;;
	--help)
	help
	;;
	--drop-dbs)
	dropDatabases
	;;
	--drop-users)
	dropUsers
	;;
	--restore-dbs)
	uploadDatabases
	;;
	*)
	echo "Invalid argument passed." && help
	;;
esac
