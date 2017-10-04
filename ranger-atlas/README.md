# Ranger Atlas Hortonia Demo

Need to clean up the process below.. Some ToDos are listed and also convert the process into an automated script 

Also - Now that I have moved the setup stuff under the ambari-util - the some of teh paths below will chage. 

```

Run these commands on Ambari Server .. 

1. Set property atlas.feature.taxonomy.enable to true in Atlas under "Custom application-properties" section 

2. Set these parameters

ambari_uid=admin
ambari_password=admin
ambari_host=localhost
cluster_name=HDP26
ambari_url="http://${ambari_host}:8080/api/v1"
ambari_pass="admin"
ranger_host=localhost
hive_host=localhost
zeppelin_host=ZEPPELIN_HOST

3. Run the following commands 

wget -O jq https://github.com/stedolan/jq/releases/download/jq-1.5/jq-linux64
chmod +x ./jq
cp jq /usr/bin


cd ~
git clone https://github.com/sainib/masterclass  
git clone https://github.com/sainib/ambari-bootstrap.git
git clone https://github.com/sainib/ambari-util.git

source ~/ambari-bootstrap/extras/ambari_functions.sh  


###### ALSO RUN THIS SCRIPT ON THE HOST THAT HAS RANGER ADMIN AND RANGER USERSYNC !!!!!
cd ~/install/
bash copy_file.sh /root/ambari-util/ranger-atlas/HortoniaMunichSetup/04-create-os-users.sh /tmp
bash run_command.sh 'bash /tmp/04-create-os-users.sh'
cd -




########################################################################
#TODO - Restart UserSync so the new groups and users are imported into the ranger env
########################################################################


## Ambari Server specific tasks

    #Create users in Ambari before changing pass
users="kate_hr ivanna_eu_hr joe_analyst sasha_eu_hr john_finance mark_bizdev jermy_contractor diane_csr log_monitor"
groups="hr analyst us_employee eu_employee finance business_dev contractor csr etluser"

for user in ${users}; do
  echo "adding user ${user} to Ambari"
  curl -u ${ambari_uid}:${ambari_password} -H "X-Requested-By: blah" -X POST -d "{\"Users/user_name\":\"${user}\",\"Users/password\":\"${ambari_pass}\",\"Users/active\":\"true\",\"Users/admin\":\"false\"}" ${ambari_url}/users 
done 

#create groups in Ambari
for group in ${groups}; do
  curl -u ${ambari_uid}:${ambari_password} -H "X-Requested-By: blah" -X POST -d "{\"Groups/group_name\":\"${group}\"}" ${ambari_url}/groups
done


#HR group membership
curl -u ${ambari_uid}:${ambari_password} -H "X-Requested-By: blah" -X POST -d '{"MemberInfo/user_name":"kate_hr", "MemberInfo/group_name":"hr"}' ${ambari_url}/groups/hr/members
curl -u ${ambari_uid}:${ambari_password} -H "X-Requested-By: blah" -X POST -d '{"MemberInfo/user_name":"ivanna_eu_hr", "MemberInfo/group_name":"hr"}' ${ambari_url}/groups/hr/members
curl -u ${ambari_uid}:${ambari_password} -H "X-Requested-By: blah" -X POST -d '{"MemberInfo/user_name":"sasha_eu_hr", "MemberInfo/group_name":"hr"}' ${ambari_url}/groups/hr/members


#analyst group membership
curl -u ${ambari_uid}:${ambari_password} -H "X-Requested-By: blah" -X POST -d '{"MemberInfo/user_name":"joe_analyst", "MemberInfo/group_name":"analyst"}' ${ambari_url}/groups/analyst/members

#us_employee group membership
curl -u ${ambari_uid}:${ambari_password} -H "X-Requested-By: blah" -X POST -d '{"MemberInfo/user_name":"kate_hr", "MemberInfo/group_name":"us_employee"}' ${ambari_url}/groups/us_employee/members
curl -u ${ambari_uid}:${ambari_password} -H "X-Requested-By: blah" -X POST -d '{"MemberInfo/user_name":"joe_analyst", "MemberInfo/group_name":"us_employee"}' ${ambari_url}/groups/us_employee/members

#eu_employee group membership
curl -u ${ambari_uid}:${ambari_password} -H "X-Requested-By: blah" -X POST -d '{"MemberInfo/user_name":"ivanna_eu_hr", "MemberInfo/group_name":"eu_employee"}' ${ambari_url}/groups/eu_employee/members
curl -u ${ambari_uid}:${ambari_password} -H "X-Requested-By: blah" -X POST -d '{"MemberInfo/user_name":"sasha_eu_hr", "MemberInfo/group_name":"eu_employee"}' ${ambari_url}/groups/eu_employee/members

#finance group membership
curl -u ${ambari_uid}:${ambari_password} -H "X-Requested-By: blah" -X POST -d '{"MemberInfo/user_name":"john_finance", "MemberInfo/group_name":"finance"}' ${ambari_url}/groups/finance/members

#bizdev group membership
curl -u ${ambari_uid}:${ambari_password} -H "X-Requested-By: blah" -X POST -d '{"MemberInfo/user_name":"mark_bizdev", "MemberInfo/group_name":"business_dev"}' ${ambari_url}/groups/business_dev/members

#contractor group membership
curl -u ${ambari_uid}:${ambari_password} -H "X-Requested-By: blah" -X POST -d '{"MemberInfo/user_name":"jermy_contractor", "MemberInfo/group_name":"contractor"}' ${ambari_url}/groups/contractor/members

#csr group membership
curl -u ${ambari_uid}:${ambari_password} -H "X-Requested-By: blah" -X POST -d '{"MemberInfo/user_name":"diane_csr", "MemberInfo/group_name":"csr"}' ${ambari_url}/groups/csr/members

#csr group membership
curl -u ${ambari_uid}:${ambari_password} -H "X-Requested-By: blah" -X POST -d '{"MemberInfo/user_name":"log_monitor", "MemberInfo/group_name":"etluser"}' ${ambari_url}/groups/etluser/members
        
## add admin user to postgres for other services, such as Ranger

cd ~
source ~/ambari-bootstrap/extras/ambari_functions.sh
host=$(hostname -f)

#add groups to Hive view
curl -u ${ambari_uid}:${ambari_pass} -i -H "X-Requested-By: blah" -X PUT ${ambari_url}/views/HIVE/versions/1.5.0/instances/AUTO_HIVE_INSTANCE/privileges \
   --data '[{"PrivilegeInfo":{"permission_name":"VIEW.USER","principal_name":"us_employee","principal_type":"GROUP"}},{"PrivilegeInfo":{"permission_name":"VIEW.USER","principal_name":"business_dev","principal_type":"GROUP"}},{"PrivilegeInfo":{"permission_name":"VIEW.USER","principal_name":"eu_employee","principal_type":"GROUP"}},{"PrivilegeInfo":{"permission_name":"VIEW.USER","principal_name":"CLUSTER.ADMINISTRATOR","principal_type":"ROLE"}},{"PrivilegeInfo":{"permission_name":"VIEW.USER","principal_name":"CLUSTER.OPERATOR","principal_type":"ROLE"}},{"PrivilegeInfo":{"permission_name":"VIEW.USER","principal_name":"SERVICE.OPERATOR","principal_type":"ROLE"}},{"PrivilegeInfo":{"permission_name":"VIEW.USER","principal_name":"SERVICE.ADMINISTRATOR","principal_type":"ROLE"}},{"PrivilegeInfo":{"permission_name":"VIEW.USER","principal_name":"CLUSTER.USER","principal_type":"ROLE"}}]'
        

***********************************
* RUN ON THE ZEPPELIN SERVER * 
***********************************
## update zeppelin notebooks
curl -sSL https://raw.githubusercontent.com/hortonworks-gallery/zeppelin-notebooks/master/update_all_notebooks.sh | sudo -E sh 


########################################################################
# RESTART ATLAS & Kafka Using Ambari
########################################################################

#update zeppelin configs by uncommenting admin user, enabling sessionManager/securityManager, switching from anon to authc

/var/lib/ambari-server/resources/scripts/configs.sh -u ${ambari_uid} -p ${ambari_password} get ${ambari_host} ${cluster_name} zeppelin-shiro-ini \
| sed -e '1,3d' \
-e "s/admin = admin, admin/admin = ${ambari_pass},${ambari_uid}/"  \
-e "s/user1 = user1, role1, role2/ivanna_eu_hr = ${ambari_pass}, ${ambari_uid}/" \
-e "s/user2 = user2, role3/diane_csr = ${ambari_pass}, ${ambari_uid}/" \
-e "s/user3 = user3, role2/joe_analyst = ${ambari_pass}, ${ambari_uid}/" \
> ~/zeppelin-env.json


/var/lib/ambari-server/resources/scripts/configs.sh -u ${ambari_uid} -p ${ambari_password} set ${ambari_host} ${cluster_name} zeppelin-shiro-ini ~/zeppelin-env.json
sleep 5
      
      #restart Zeppelin
      sudo curl -u admin:${ambari_pass} -H 'X-Requested-By: blah' -X POST -d "
{
   \"RequestInfo\":{
      \"command\":\"RESTART\",
      \"context\":\"Restart Zeppelin\",
      \"operation_level\":{
         \"level\":\"HOST\",
         \"cluster_name\":\"${cluster_name}\"
      }
   },
   \"Requests/resource_filters\":[
      {
         \"service_name\":\"ZEPPELIN\",
         \"component_name\":\"ZEPPELIN_MASTER\",
         \"hosts\":\"${zeppelin_host}\"
      }
   ]
}" ${ambari_url}/clusters/${cluster_name}/requests  


while ! echo exit | nc ${ambari_host} 21000; do echo "waiting for atlas to come up..."; sleep 10; done
sleep 30
    
## update ranger to support deny policies
ranger_curl="curl -u ${ambari_uid}:${ambari_password}"
ranger_url="http://${ranger_host}:6080/service"


${ranger_curl} ${ranger_url}/public/v2/api/servicedef/name/hive \
  | jq '.options = {"enableDenyAndExceptionsInPolicies":"true"}' \
  | jq '.policyConditions = [
{
	  "itemId": 1,
	  "name": "resources-accessed-together",
	  "evaluator": "org.apache.ranger.plugin.conditionevaluator.RangerHiveResourcesAccessedTogetherCondition",
	  "evaluatorOptions": {},
	  "label": "Resources Accessed Together?",
	  "description": "Resources Accessed Together?"
},{
	"itemId": 2,
	"name": "not-accessed-together",
	"evaluator": "org.apache.ranger.plugin.conditionevaluator.RangerHiveResourcesNotAccessedTogetherCondition",
	"evaluatorOptions": {},
	"label": "Resources Not Accessed Together?",
	"description": "Resources Not Accessed Together?"
}
]' > ~/hive.json

cd
${ranger_curl} -i \
  -X PUT -H "Accept: application/json" -H "Content-Type: application/json" \
  -d @hive.json ${ranger_url}/public/v2/api/servicedef/name/hive
sleep 10


cd ~/masterclass/ranger-atlas/Scripts/

```

For this next part, use Ambari ..

* Create the clusterName_hive, hadoop adn kafka policy.. 
- To turn on the Ranger plugin, 
<img src="https://github.com/sainib/ambari-util/blob/master/ranger-atlas/media/Screen%20Shot%202017-10-04%20at%205.16.54%20PM.png" />

After that is done, back to command line - 

```
## import ranger Hive policies for masking etc - needs to be done before creating HDFS folders

< ranger-policies-enabled.json jq '.policies[].service = "'${cluster_name}'_hive"' > ranger-policies-apply.json
	
${ranger_curl} -X POST \
-H "Content-Type: multipart/form-data" \
-H "Content-Type: application/json" \
-F 'file=@ranger-policies-apply.json' \
		  "${ranger_url}/plugins/policies/importPoliciesFromFile?isOverride=true&serviceType=hive"

## import ranger HDFS policies - to give hive access to /hive_data HDFS dir
< ranger-hdfs-policies.json jq '.policies[].service = "'${cluster_name}'_hadoop"' > ranger-hdfs-policies-apply.json

${ranger_curl} -X POST \
-H "Content-Type: multipart/form-data" \
-H "Content-Type: application/json" \
-F 'file=@ranger-hdfs-policies-apply.json' \
		  "${ranger_url}/plugins/policies/importPoliciesFromFile?isOverride=true&serviceType=hdfs"

## import ranger kafka policies - to give ANONYMOUS access to kafka or Atlas won't work
< ranger-kafka-policies.json jq '.policies[].service = "'${cluster_name}'_kafka"' > ranger-kafka-policies-apply.json

${ranger_curl} -X POST \
-H "Content-Type: multipart/form-data" \
-H "Content-Type: application/json" \
-F 'file=@ranger-kafka-policies-apply.json' \
		  "${ranger_url}/plugins/policies/importPoliciesFromFile?isOverride=true&serviceType=kafka"
sleep 40    


########################################################################
### Manually Create a new service for tag based policies with any service name 
########################################################################

## Import Tags

 ${ranger_curl} -X POST \
-H "Content-Type: multipart/form-data" \
-H "Content-Type: application/json" \
-F 'file=@ranger-policies-tags-PII_EXPIRES.json' \
		  "${ranger_url}/plugins/policies/importPoliciesFromFile?isOverride=true&serviceType=tag"
	  

cd ~/ambari-util/ranger-atlas/HortoniaMunichSetup
./01-atlas-import-classification.sh
./02-atlas-import-entities.sh
./03-update-servicedefs.sh

		
cd ~/ambari-util/ranger-atlas/HortoniaMunichSetup
su hdfs -c ./05-create-hdfs-user-folders.sh

cp -R ./data /tmp/atdata
chmod -R 777 /tmp/atdata
sudo -u hdfs hdfs dfs -put /tmp/atdata/claims_provider_summary_data.csv /hive_data/claim/
sudo -u hdfs hdfs dfs -put /tmp/atdata/claim-savings.csv                /hive_data/cost_savings/
sudo -u hdfs hdfs dfs -put /tmp/atdata/tax_2009.csv                     /hive_data/finance/tax_2009/
sudo -u hdfs hdfs dfs -put /tmp/atdata/tax_2010.csv                     /hive_data/finance/tax_2010/
sudo -u hdfs hdfs dfs -put /tmp/atdata/tax_2015.csv                     /hive_data/finance/tax_2015/
sudo -u hdfs hdfs dfs -put /tmp/atdata/eu_countries.csv                 /hive_data/hortoniabank/eu_countries/
sudo -u hdfs hdfs dfs -put /tmp/atdata/us_customers_data.csv            /hive_data/hortoniabank/us_customers/
sudo -u hdfs hdfs dfs -put /tmp/atdata/ww_customers_data.csv            /hive_data/hortoniabank/ww_customers/


sleep 20

set -e
beeline -u "jdbc:hive2://${hive_host}:10000" -n hive -e "show databases"
beeline -u "jdbc:hive2://${hive_host}:10000" -n hive -f data/HiveSchema.hsql
beeline -u "jdbc:hive2://${hive_host}:10000" -n hive -e "show databases"
    

### MANUALLY IMPORT THE ZEPPELIN NOTEBOOKS FROM HERE -- https://github.com/sainib/ambari-util/tree/master/ranger-atlas/Notebooks


echo "Done!"
 

```
