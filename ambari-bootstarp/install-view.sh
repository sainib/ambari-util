#!/bin/sh

viewname=$1

hdfs dfs -get /tmp/$1

chmod 777 $1

ambari-server stop

rm -rf /var/lib/ambari-server/resources/views/$1

mv ./$1 /var/lib/ambari-server/resources/views/$1

ambari-server start
