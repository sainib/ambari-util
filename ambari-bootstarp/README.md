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

bash worker-overall.sh

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

wget -nv http://public-repo-1.hortonworks.com/ambari/centos7/2.x/updates/2.5.2.0/ambari.repo -O /etc/yum.repos.d/ambari.repo

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
* Use the following details for the Ranger Audit - https://docs.hortonworks.com/HDPDocuments/HDP2/HDP-2.6.1/bk_security/content/manually_updating_ambari_solr_audit_settings.html
<img src="https://github.com/sainib/ambari-util/blob/master/ambari-bootstarp/Ranger_Audit.png" />




## Environment Setup
```
sudo -u hdfs hdfs dfs -mkdir /user/admin
sudo -u hdfs hdfs dfs -chmod 755 /user/admin
sudo -u hdfs hdfs dfs -chown admin:hdfs /user/admin
```

# HDF Setup 

## HDF Management Pack 
```
ambari-server stop
wget -nv http://public-repo-1.hortonworks.com/HDF/centos6/3.x/updates/3.0.1.1/tars/hdf_ambari_mp/hdf-ambari-mpack-3.0.1.1-5.tar.gz -O /tmp/hdf-ambari-mpack-3.0.1.1-5.tar.gz
ambari-server install-mpack --mpack=/tmp/hdf-ambari-mpack-3.0.1.1-5.tar.gz --verbose
ambari-server start
```

## Install MySQL for SchemaRegistry and SAM, Update MySQL Password & create users 

```
yum install mysql-connector-java* \
sudo ambari-server setup --jdbc-db=mysql \
--jdbc-driver=/usr/share/java/mysql-connector-java.jar 

yum localinstall \
https://dev.mysql.com/get/mysql57-community-release-el7-8.noarch.rpm

yum -y install mysql-community-server

systemctl start mysqld.service

grep 'A temporary password is generated for root@localhost' \
/var/log/mysqld.log |tail -1

/usr/bin/mysql_secure_installation
Change the root user password.. and use that as dba admin 


mysql -u root -p

#### mysql 
CREATE USER 'registry'@'%' IDENTIFIED BY '9oNio)ex1ndL';
CREATE DATABASE registry DEFAULT CHARACTER SET utf8;
GRANT ALL PRIVILEGES ON *.* TO 'registry'@'%' WITH GRANT OPTION;


CREATE USER 'streamline'@'%' IDENTIFIED BY '9oNio)ex1ndL';
CREATE DATABASE streamline DEFAULT CHARACTER SET utf8;
GRANT ALL PRIVILEGES ON *.* TO 'streamline'@'%' WITH GRANT OPTION;

commit;

FLUSH PRIVILEGES;
```
