#!/bin/bash

if [ $# -lt 1 ]; then
	echo "ERROR: Profile the file name to store the blueprint"
	exit 1
fi
fn=$1
if [ !  -f "$fn" ] ; then
                echo "ERROR: Blueprint file does not exist. Provide a file that exists"
                exit 1
fi 

rm active_bp.json
cp $fn active_bp.json

curl -H "X-Requested-By: ambari" -u admin:admin -X POST -d @active_bp.json http://birens0.field.hortonworks.com:8080/api/v1/blueprints/secloud-openstack-8node

