#!/bin/sh

if [ $# -lt 1 ]; then
	echo "ERROR: Profile the file name to store the blueprint"
	exit 1
fi
fn=$1
if [  -f "$fn" ] ; then
                echo "ERROR: File already exists. We dont want to overwrite the existing file, do we?"
                exit 1
fi 

curl -H "X-Requested-By: ambari" -u admin:admin -X GET http://birens0.field.hortonworks.com:8080/api/v1/clusters/HDP?format=blueprint > $fn
