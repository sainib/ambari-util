##Amabri DB Operations (Posgres)

###Dump the database into a file
pg_dump -U ambari ambari > ambari_db.sql
(Password: bigdata) 

###Login to Ambari Db via commandline 
psql -U ambari ambari
(Password: bigdata) 


