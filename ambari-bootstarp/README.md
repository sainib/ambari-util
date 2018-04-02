# Steps to quickly bootstrap Openstack based cluster

# Overview 

## Run the following on AMBARI NODE ONLY
### This step will install git and get the code. 
------------------------------------------------
```
sudo su 

yum -y install git

cd

git clone https://github.com/sainib/ambari-util.git

cd /root/ambari-util/ambari-bootstarp

bash master-0.sh


```
------------------------------------------------

------------------------------------------------
## Setup SSH nodes - NON-Ambari Nodes only

### Copy the content of the file ~/.ssh/id_rsa.pub from AMABRI SERVER - shown in previous output
```
### SSH into all other nodes and run these commands 
sudo su
echo "---PUBLIC KEY ----" >> ~/.ssh/authorized_keys
exit
exit

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
cd ~/install
echo `hostname -f` > Hostdetail.txt

##---Execute the following steps manually -----
vi Hostdetail.txt
#Add all host names in the file in the following format 
server1
server2

bash createHostsFile.sh

```

------------------------------------------------

## Run the following on ambari node
--- Run using run_command.sh 
```
bash run_command.sh 'hostname -f'

cd ~/install

bash worker-overall.sh

```

------------------------------------------------
```
TBD - Add notes to reset the mysql root password and use that for Ranger Audit Password
```


## Get Ambari Repo File 
```
* Ambari 2.5.1
wget -nv http://public-repo-1.hortonworks.com/ambari/centos7/2.x/updates/2.5.1.0/ambari.repo -O /etc/yum.repos.d/ambari.repo
* Ambari 2.5.2
wget -nv http://public-repo-1.hortonworks.com/ambari/centos7/2.x/updates/2.5.2.0/ambari.repo -O /etc/yum.repos.d/ambari.repo
* Ambari 2.6.0
wget -nv http://public-repo-1.hortonworks.com/ambari/centos7/2.x/updates/2.6.0.0/ambari.repo -O /etc/yum.repos.d/ambari.repo
* Ambari 2.6.1
wget -nv http://public-repo-1.hortonworks.com/ambari/centos7/2.x/updates/2.6.1.0/ambari.repo -O /etc/yum.repos.d/ambari.repo
* Ambari 2.6.1.3 
wget -nv http://public-repo-1.hortonworks.com/ambari/centos7/2.x/updates/2.6.1.3/ambari.repo -O /etc/yum.repos.d/ambari.repo

```

## Start the Ambari yum install
```
yum repolist
yum -y install ambari-server
ambari-server setup

yum -y install mysql-connector-java.noarch
sudo ambari-server setup --jdbc-db=mysql --jdbc-driver=/usr/share/java/mysql-connector-java.jar 

```

## Start Ambari Server
```
ambari-server start
```

## OPTION 1 ::  Install HDP
```
cd ~/install
bash run_command.sh "wget -nv http://public-repo-1.hortonworks.com/ambari/centos7/2.x/updates/2.6.0.0/ambari.repo -O /etc/yum.repos.d/ambari.repo"
bash run_command.sh "yum -y install ambari-agent"
bash run_command.sh "sed -i 's/hostname\=localhost/hostname\=birens0.field.hortonworks.com/g' /etc/ambari-agent/conf/ambari-agent.ini"
bash run_command.sh "ambari-agent start"

cd ./blueprint/
bash deregister-blueprint.sh
bash register-blueprint.sh
bash provision-cluster.sh
```

## OPTION 2 :: Install HDP
* Install wih 4 masters and 4 workers
* For masters, do the following 
  * Master 1 = Namennode etc
  * Master 2 = Hive and all hive related components 
  * Master 3 = Grafana, Metric etc (Keep it light, will be used for DRUID) 
  * Master 4 = Spark and Spark2 (Keep it light, will be used for Ranger) 
  
  
IMPORTANT - Install MySQL yourself on the Hive, Druid, Ranger and SuperSet servers (or server if its same for all servcies) 
``` 
wget http://repo.mysql.com/mysql-community-release-el7-5.noarch.rpm
sudo rpm -ivh mysql-community-release-el7-5.noarch.rpm
yum update
```


## Change configs, Complete install and Start Services. 
```
******************
** PROXY CHANGE **
******************

Change all the passwords and also proxy config in HDFS (4), YARN (1), Hive (1)

```


## Environment Setup
```
sudo -u hdfs hdfs dfs -mkdir /user/admin
sudo -u hdfs hdfs dfs -chmod 755 /user/admin
sudo -u hdfs hdfs dfs -chown admin:hdfs /user/admin

sudo -u hdfs hdfs dfs -mkdir /user/root
sudo -u hdfs hdfs dfs -chmod 755 /user/root
sudo -u hdfs hdfs dfs -chown root:hdfs /user/root

```

## Configrue MySQL For Druid 

# ON DRUID BOX ONLY - 

```
yum -y install mysql-connector-java.noarch

yum -y localinstall \
https://dev.mysql.com/get/mysql57-community-release-el7-8.noarch.rpm

yum -y install mysql-community-server

#~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
## Edit /etc/my.cnf and add the line below 
bind-address = 0.0.0.0
show_compatibility_56 = on
#~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

systemctl start mysqld.service

grep 'A temporary password is generated for root@localhost' \
/var/log/mysqld.log |tail -1

/usr/bin/mysql_secure_installation
Change the root user password.. and use that as dba admin 

mysql -u root -p

CREATE USER 'druid'@'%' IDENTIFIED BY '9oNio)ex1ndL'; CREATE USER 'superset'@'%' IDENTIFIED BY '9oNio)ex1ndL';

CREATE DATABASE druid DEFAULT CHARACTER SET utf8; CREATE DATABASE superset DEFAULT CHARACTER SET utf8;

GRANT ALL PRIVILEGES ON *.* TO 'druid'@'%' WITH GRANT OPTION; 

GRANT ALL PRIVILEGES ON *.* TO 'superset'@'%' WITH GRANT OPTION; 

commit;

CREATE USER 'druid'@'127.0.0.1' IDENTIFIED BY '9oNio)ex1ndL'; 

CREATE USER 'superset'@'127.0.0.1' IDENTIFIED BY '9oNio)ex1ndL';

CREATE USER 'druid'@'SERVER' IDENTIFIED BY '9oNio)ex1ndL'; 

CREATE USER 'superset'@'SERVER' IDENTIFIED BY '9oNio)ex1ndL';

CREATE USER 'druid'@'SERVER.DOMAIN.COM' IDENTIFIED BY '9oNio)ex1ndL'; 

CREATE USER 'superset'@'SERVER.DOMAIN.COM' IDENTIFIED BY '9oNio)ex1ndL';

CREATE USER 'druid'@'localhost' IDENTIFIED BY '9oNio)ex1ndL'; 

CREATE USER 'superset'@'localhost' IDENTIFIED BY '9oNio)ex1ndL';

GRANT ALL PRIVILEGES ON *.* TO 'druid'@'%' WITH GRANT OPTION; 

GRANT ALL PRIVILEGES ON *.* TO 'superset'@'%' WITH GRANT OPTION;

GRANT ALL PRIVILEGES ON *.* TO 'druid'@'**SERVER**' WITH GRANT OPTION; 

GRANT ALL PRIVILEGES ON *.* TO 'superset'@'**SERVER**' WITH GRANT OPTION;

GRANT ALL PRIVILEGES ON *.* TO 'druid'@'**SERVER.DOMAIN.COM**' WITH GRANT OPTION; 

GRANT ALL PRIVILEGES ON *.* TO 'superset'@'**SERVER.DOMAIN.COM**' WITH GRANT OPTION;

GRANT ALL PRIVILEGES ON *.* TO 'druid'@'localhost' WITH GRANT OPTION; 

GRANT ALL PRIVILEGES ON *.* TO 'superset'@'localhost' WITH GRANT OPTION;

CREATE USER 'root'@'**SERVER.DOMAIN.COM**' IDENTIFIED BY '9oNio)ex1ndL'; 

GRANT ALL PRIVILEGES ON *.* TO 'root'@'**SERVER.DOMAIN.COM**' WITH GRANT OPTION;

commit;

FLUSH PRIVILEGES;


```


## Install Ranger 

Install Ranger on host different than the one that has Hive or Druid metastore

```
* No need to pre-create uses for Ranger as those can be created by the root use via Ambari. just suppy the root password. 
* However, we need to install MySQl and reset the root password 

yum -y install mysql-connector-java.noarch

yum -y localinstall \
https://dev.mysql.com/get/mysql57-community-release-el7-8.noarch.rpm

yum -y install mysql-community-server

#~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
## Edit /etc/my.cnf and add the line below 
bind-address = 0.0.0.0
#~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

systemctl start mysqld.service

grep 'A temporary password is generated for root@localhost' \
/var/log/mysqld.log |tail -1

/usr/bin/mysql_secure_installation
Change the root user password.. and use that as dba admin 

mysql -u root -p

CREATE USER 'root'@'SERVER.DOMAIN.COM' IDENTIFIED BY '9oNio)ex1ndL'; 

GRANT ALL PRIVILEGES ON *.* TO 'root'@'SERVER.DOMAIN.COM' WITH GRANT OPTION;

commit;

FLUSH PRIVILEGES;


```


------------------------------------------------


* Run the following command on MySQL server to reset the password for root user. 
/usr/bin/mysql_secure_installation

* Update the Ranger Admin info with the dbadmin password as the root and the set password. 
* Add Ranger via Ambari URL 
* Provide the details of the dbadmin creds
* Use the following details for the Ranger Audit - https://docs.hortonworks.com/HDPDocuments/HDP2/HDP-2.6.1/bk_security/content/manually_updating_ambari_solr_audit_settings.html
<img src="https://github.com/sainib/ambari-util/blob/master/ambari-bootstarp/Ranger_Audit.png" />

------------------------------------------------
------------------------------------------------
------------------------------------------------



# HDF Setup 

## JUST NIFI 
```
wget https://s3.amazonaws.com/public-repo-1.hortonworks.com/HDF/3.0.2.0/nifi-1.2.0.3.0.2.0-76-bin.zip

wget https://public-repo-1.hortonworks.com/HDF/3.1.1.0/nifi-1.5.0.3.1.1.0-35-bin.tar.gz
```

## HDF Management Pack 
```
ambari-server stop
wget -nv http://public-repo-1.hortonworks.com/HDF/centos6/3.x/updates/3.0.1.1/tars/hdf_ambari_mp/hdf-ambari-mpack-3.0.1.1-5.tar.gz -O /tmp/hdf-ambari-mpack-3.0.1.1-5.tar.gz
ambari-server install-mpack --mpack=/tmp/hdf-ambari-mpack-3.0.1.1-5.tar.gz --verbose
ambari-server start
```

## Install MySQL for SchemaRegistry and SAM, Update MySQL Password & create users 

```
yum -y install mysql-connector-java.noarch

sudo ambari-server setup --jdbc-db=mysql \
--jdbc-driver=/usr/share/java/mysql-connector-java.jar 

yum -y localinstall \
https://dev.mysql.com/get/mysql57-community-release-el7-8.noarch.rpm

yum -y install mysql-community-server

#~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
## Edit /etc/my.cnf and add the line below 
bind-address = 0.0.0.0
#~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

systemctl start mysqld.service

grep 'A temporary password is generated for root@localhost' \
/var/log/mysqld.log |tail -1

/usr/bin/mysql_secure_installation
Change the root user password.. and use that as dba admin 

mysql -u root -p

CREATE USER 'registry'@'%' IDENTIFIED BY '9oNio)ex1ndL'; CREATE USER 'streamline'@'%' IDENTIFIED BY '9oNio)ex1ndL';

CREATE DATABASE registry DEFAULT CHARACTER SET utf8; CREATE DATABASE streamline DEFAULT CHARACTER SET utf8;

GRANT ALL PRIVILEGES ON *.* TO 'registry'@'%' WITH GRANT OPTION; 

GRANT ALL PRIVILEGES ON *.* TO 'streamline'@'%' WITH GRANT OPTION; 

commit;

CREATE USER 'registry'@'127.0.0.1' IDENTIFIED BY '9oNio)ex1ndL'; 

CREATE USER 'streamline'@'127.0.0.1' IDENTIFIED BY '9oNio)ex1ndL';

CREATE USER 'registry'@'SERVER' IDENTIFIED BY '9oNio)ex1ndL'; 

CREATE USER 'streamline'@'SERVER' IDENTIFIED BY '9oNio)ex1ndL';

CREATE USER 'registry'@'SERVER.DOMAIN.COM' IDENTIFIED BY '9oNio)ex1ndL'; 

CREATE USER 'streamline'@'SERVER.DOMAIN.COM' IDENTIFIED BY '9oNio)ex1ndL';

CREATE USER 'registry'@'localhost' IDENTIFIED BY '9oNio)ex1ndL'; 

CREATE USER 'streamline'@'localhost' IDENTIFIED BY '9oNio)ex1ndL';

GRANT ALL PRIVILEGES ON *.* TO 'registry'@'%' WITH GRANT OPTION; 

GRANT ALL PRIVILEGES ON *.* TO 'streamline'@'%' WITH GRANT OPTION;

GRANT ALL PRIVILEGES ON *.* TO 'registry'@'SERVER' WITH GRANT OPTION; 

GRANT ALL PRIVILEGES ON *.* TO 'streamline'@'SERVER' WITH GRANT OPTION;

GRANT ALL PRIVILEGES ON *.* TO 'registry'@'SERVER.DOMAIN.COM' WITH GRANT OPTION; 

GRANT ALL PRIVILEGES ON *.* TO 'streamline'@'SERVER.DOMAIN.COM' WITH GRANT OPTION;

GRANT ALL PRIVILEGES ON *.* TO 'registry'@'localhost' WITH GRANT OPTION; 

GRANT ALL PRIVILEGES ON *.* TO 'streamline'@'localhost' WITH GRANT OPTION;

CREATE USER 'root'@'SERVER.DOMAIN.COM' IDENTIFIED BY '9oNio)ex1ndL'; 

GRANT ALL PRIVILEGES ON *.* TO 'root'@'SERVER.DOMAIN.COM' WITH GRANT OPTION;

commit;

FLUSH PRIVILEGES;


```
