#!/bin/bash

#Set Ambari username/password, and cluster name here
USER=admin
PASS=admin
HOST=ambari-host:8080
CLUSTER=Sandbox

#------DO NOT CHANGE BELOW THIS LINE ----- 
SERVICE=HBASE


#---- LETS BACKUP THE CONF FILES - JUST IN CASE --- 
mkdir -p /tmp/hbase-install/pre-install/conf-backup
cp -rf /etc/ambari-server /tmp/hbase-install/pre-install/conf-backup/ 2>/dev/null
cp -rf /etc/ambari-agent /tmp/hbase-install/pre-install/conf-backup/ 2>/dev/null
cp -rf /etc/zookeeper /tmp/hbase-install/pre-install/conf-backup/ 2>/dev/null
cp -rf /etc/slider /tmp/hbase-install/pre-install/conf-backup/ 2>/dev/null
cp -rf /etc/storm-slider-client /tmp/hbase-install/pre-install/conf-backup/ 2>/dev/null
cp -rf /etc/falcon /tmp/hbase-install/pre-install/conf-backup/ 2>/dev/null
cp -rf /etc/flume /tmp/hbase-install/pre-install/conf-backup/ 2>/dev/null
cp -rf /etc/hbase /tmp/hbase-install/pre-install/conf-backup/ 2>/dev/null
cp -rf /etc/hive-hcatalog /tmp/hbase-install/pre-install/conf-backup/ 2>/dev/null
cp -rf /etc/kafka /tmp/hbase-install/pre-install/conf-backup/ 2>/dev/null
cp -rf /etc/oozie /tmp/hbase-install/pre-install/conf-backup/ 2>/dev/null
cp -rf /etc/pig /tmp/hbase-install/pre-install/conf-backup/ 2>/dev/null
cp -rf /etc/sqoop /tmp/hbase-install/pre-install/conf-backup/ 2>/dev/null
cp -rf /etc/tez /tmp/hbase-install/pre-install/conf-backup/ 2>/dev/null
cp -rf /etc/hive-webhcat /tmp/hbase-install/pre-install/conf-backup/ 2>/dev/null
cp -rf /etc/storm /tmp/hbase-install/pre-install/conf-backup/ 2>/dev/null
cp -rf /etc/knox /tmp/hbase-install/pre-install/conf-backup/ 2>/dev/null
cp -rf /etc/hive /tmp/hbase-install/pre-install/conf-backup/ 2>/dev/null


#---- LETS STOP HBASE SERVER --- 
curl -u $USER:$PASS -i -H 'X-Requested-By: ambari' -X PUT -d \
  '{"RequestInfo": {"context" :"Stop '"$SERVICE"' via REST"}, "Body": {"ServiceInfo": {"state": "INSTALLED"}}}' \
  http://$HOST/api/v1/clusters/$CLUSTER/services/$SERVICE

#---- LETS REMOVE HBASE FROM AMBARI --- 
echo Removing $SERVICE from Ambari Service Registry..
curl -u $USER:$PASS -i -H 'X-Requested-By: ambari' -X DELETE http://$HOST/api/v1/clusters/$CLUSTER/services/$SERVICE

#---- LETS UNINSTALL HBASE AND DELETE THE FILES  --- 
yum remove hbase\*
rm -rf /usr/hdp/current/hbase-client
rm -rf /usr/hdp/current/hbase-master
rm -rf /usr/hdp/current/hbase-regionserver


