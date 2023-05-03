#!/bin/bash
### Copyright 1999-2023. Plesk International GmbH.

plesk db "SELECT d.id AS domain_id, d.name AS domain_name, sys_users.id AS sys_user_id, sys_users.login AS sys_user_login, Subscriptions.object_id AS subscription_id, clients.id AS client_id, clients.login AS client_login FROM domains AS d JOIN domains AS webspaceDomain ON CASE d.webspace_id WHEN 0 THEN d.id ELSE d.webspace_id END = webspaceDomain.id JOIN hosting ON d.id = hosting.dom_id JOIN sys_users ON sys_users.id = hosting.sys_user_id JOIN Subscriptions ON Subscriptions.object_id = CASE d.webspace_id WHEN 0 THEN d.id ELSE d.webspace_id END AND Subscriptions.object_type = 'domain' JOIN clients ON clients.id = d.cl_id;"
