# Steps to quickly bootstrap Openstack based cluster

# Overview 

## Run the following on ALL nodes 
### This step will install git and get the code. 
------------------------------------------------
```
sudo su 

yum -y install git

cd

git clone https://github.com/sainib/ambari-util.git

cd /root/ambari-util/ambari-bootstarp

bash master-worker-0.sh
```
------------------------------------------------

------------------------------------------------
## Setup SSH nodes - NON-Ambari Nodes only

### Copy the content of the file ~/.ssh/id_rsa.pub from AMABRI SERVER - shown in previous output
```
### Paste that content into this file on all nodes
vi ~/.ssh/authorized_keys

```

### Test that password-less SSH is working from ambari to other nodes.
```
#run the command on ambari node
ssh <node-name>
```

------------------------------------------------


## Run the following on ambari node
### This step will create the directory under ~ to centrally place the files needed for the setup process. 
------------------------------------------------

```
cd 
mkdir install 
cd ~/install
cp /root/ambari-util/ambari-bootstarp/* . 

##---Execute the following steps manually -----
vi Hostdetail.txt
#Add all host names in the file in the following format 
server1
server2

bash createHostsFile.sh

##---Execute the following steps manually -----
unzip tools.zip
cp ./tools/* .
rm -rf __MACOSX/ tools
```

------------------------------------------------

## Run the following on ambari node
--- Run using run_command.sh 
```
cd ~/install
bash run_command.sh 'ifconfig'  | grep broadcast | grep netmask
bash run_command.sh 'yum install -y -q curl ntp openssl python zlib wget unzip openssh-clients'
bash run_command.sh 'systemctl is-enabled ntpd'
bash run_command.sh 'systemctl enable ntpd'
bash run_command.sh 'systemctl start ntpd'

bash copy_file.sh ~/install/hosts /tmp
bash copy_file.sh ~/install/worker-0.sh /tmp

bash run_command.sh 'bash /tmp/worker-0.sh'
bash run_command.sh 'umask 0022'

bash copy_file.sh ~/install/worker-1.sh /tmp
bash run_command.sh 'bash /tmp/worker-1.sh'

#Lets check the configs to confirm updates
bash run_command.sh 'hostname'
bash run_command.sh 'hostname -f'
bash run_command.sh 'cat /etc/sysconfig/network'
bash run_command.sh 'cat /etc/selinux/config'

```

------------------------------------------------
```
TBD - Add notes to reset the mysql root password and use that for Ranger Audit Password
```





## Start the Ambari yum install
```
wget -nv <Ambari-Repo-URL> -O /etc/yum.repos.d/ambari.repo
yum repolist
yum -y install ambari-server
ambari-server setup
ambari-server setup --jdbc-db=mysql --jdbc-driver=/root/install/mysql-connector-java.jar
```

## Ambari 2.5.1.0
```
wget -nv http://public-repo-1.hortonworks.com/ambari/centos7/2.x/updates/2.5.1.0/ambari.repo -O /etc/yum.repos.d/ambari.repo
```


## HDF Management Pack 
```
ambari-server stop
wget -nv http://public-repo-1.hortonworks.com/HDF/centos6/3.x/updates/3.0.1.1/tars/hdf_ambari_mp/hdf-ambari-mpack-3.0.1.1-5.tar.gz -O /tmp/hdf-ambari-mpack-3.0.1.1-5.tar.gz
ambari-server install-mpack --mpack=/tmp/hdf-ambari-mpack-3.0.1.1-5.tar.gz --verbose
ambari-server start
```

## Start Ambari Server
```
ambari-server start
```


## Install HDP

## Install Ranger 

* Add user to the MySQL 

```
# MySQL Changes - Login to MySQl on Hive Server 

CREATE USER 'druid'@'%' IDENTIFIED BY '9oNio)ex1ndL';
CREATE USER 'superset'@'%' IDENTIFIED BY '9oNio)ex1ndL';

CREATE DATABASE druid DEFAULT CHARACTER SET utf8;
CREATE DATABASE superset DEFAULT CHARACTER SET utf8;

GRANT ALL PRIVILEGES ON *.* TO 'druid'@'%' WITH GRANT OPTION;
GRANT ALL PRIVILEGES ON *.* TO 'superset'@'%' WITH GRANT OPTION;

```
* Run the following command on MySQL server to reset the password for root user. 
/usr/bin/mysql_secure_installation

* Update the Ranger Admin info with the dbadmin password as the root and the set password. 
* Add Ranger via Ambari URL 
* Provide the details of the dbadmin creds
* Use the following details for the Ranger Audit 
<img src="https://github.com/sainib/ambari-util/blob/master/ambari-bootstarp/Ranger_Audit.png" />




## Environment Setup
```
sudo -u hdfs hdfs dfs -mkdir /user/admin
sudo -u hdfs hdfs dfs -chmod 755 /user/admin
sudo -u hdfs hdfs dfs -chown admin:hdfs /user/admin
```

