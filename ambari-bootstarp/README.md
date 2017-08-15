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


##Start the Ambari yum install
```
wget -nv <Ambari-Repo-URL> -O /etc/yum.repos.d/ambari.repo
yum repolist
yum -y install ambari-server
ambari-server setup
ambari-server setup --jdbc-db=mysql --jdbc-driver=/root/install/mysql-connector-java.jar
```
HDP 2.6 
```
wget -nv http://public-repo-1.hortonworks.com/ambari/centos7/2.x/updates/2.5.1.0/ambari.repo -O /etc/yum.repos.d/ambari.repo
```

## Start Ambari Server
```
ambari-server start
```


## Install HDP


## Environment Setup
```
sudo -u hdfs hdfs dfs -mkdir /user/admin
sudo -u hdfs hdfs dfs -chmod 755 /user/admin
sudo -u hdfs hdfs dfs -chown admin:hdfs /user/admin
```

