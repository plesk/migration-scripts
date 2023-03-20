#!/bin/bash

plesk db "SELECT db.name as 'Database', dbs.id as 'DB_Server_id', dbs.host as 'DB_Host', d.name as 'Subscription', c.pname as 'Owner', c.login as 'Customer Username' FROM data_bases db,domains d,clients c,DatabaseServers dbs WHERE d.cl_id=c.id and db.dom_id=d.id and dbs.id=db.db_server_id;"