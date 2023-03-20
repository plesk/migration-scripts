Scripts are for selecting some IDs from Plesk database. 

Sample outputs:

select-ids-1.sh:

+-----------+----------------------------+-------------+----------------+-----------------+-----------+--------------+
| domain_id | domain_name                | sys_user_id | sys_user_login | subscription_id | client_id | client_login |
+-----------+----------------------------+-------------+----------------+-----------------+-----------+--------------+
|         8 | testsubscription1.local    |           8 | testsub1       |               8 |         1 | admin        |
|        13 | testsubscription6.local    |          13 | testsub6       |              13 |         1 | admin        |
+-----------+----------------------------+-------------+----------------+-----------------+-----------+--------------+

select-ids-2.sh:

+----------+--------------+-----------+-------------------------+----------------------------+-------------------+
| Database | DB_Server_id | DB_Host   | Subscription            | Owner                      | Customer Username |
+----------+--------------+-----------+-------------------------+----------------------------+-------------------+
| wp_nkt1i |            1 | localhost | testsubscription3.local | Default_Administrator_Name | admin             |
+----------+--------------+-----------+-------------------------+----------------------------+-------------------+

select-ids-3.sh:

+-----------+-------------------------+-------------+----------------+-----------------+-----------------+
| domain_id | domain_name             | sys_user_id | sys_user_login | service_plan_id | subscription_id |
+-----------+-------------------------+-------------+----------------+-----------------+-----------------+
|         8 | testsubscription1.local |           8 | testsub1       |               3 |               8 |
|        13 | testsubscription6.local |          13 | testsub6       |               3 |              13 |
+-----------+-------------------------+-------------+----------------+-----------------+-----------------+

Just add the executable permission and run.