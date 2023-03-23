The script is designed to:
- dump databases from a remote MySQL server to a local dir(where the script being run from)
- drop databases and users from a remote MySQL server.
- restore database dumps from the directory where the script is located onto a remote MySQL server

Usage: 
Make sure the 'passwd.txt' file with the remote MySQL username and password exists in the same directory with a script 
with a single delimeter. For example:
jdoe ; password123

If port is a custom one, adjust the PORT variable manually.

Call the script using ip as a first argument and action as a second argument. Available actions are:
--dump        dumps all databases from a remote server to the script's local dir
--drop-dbs    deletes all databases(except information_schema, mysql and performance_schema) from a remote server 
--drop-users  deletes all users from a remote MySQL server(except the one being used by script)
--restore-dbs uploads databases from $DIR to a remote MySQL server
