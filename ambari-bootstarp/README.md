# Steps to quickly bootstrap Openstack based cluster

# Overview 

## Run the following on ALL nodes 
### This step will install git and get the code. 
------------------------------------------------
```
yum -y install git

cd

git clone https://github.com/sainib/ambari-util.git

bash master-worker-0.sh
```
------------------------------------------------

------------------------------------------------
## Run the following on all worker nodes
### This step will generate ssh keys
### Copy the ssh keys FROM ambari server nodes TO all other nodes
```
# Before running the commands below - copy the content of the file ~/.ssh/id_rsa.pub on AMABRI SERVER
ssh-keygen
vi ~/.ssh/authorized_keys
# Add the content of the file ~/.ssh/id_rsa.pub on AMABRI SERVER into this file on this node
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
cp /root/ambari-util/ambari-bootstarp/worker* . 


##---Execute the following steps manually -----
vi Hostdetail.txt
#Add all host names in the file 

vi ~/install/hosts
#Add all host enteries 
```

------------------------------------------------


--- Run using run_command.sh 
```
bash run_command.sh 'ifconfig'  | grep broadcast | grep netmask
bash run_command.sh 'yum install -y -q curl ntp openssl python zlib wget unzip openssh-clients'
bash run_command.sh 'systemctl is-enabled ntpd'
bash run_command.sh 'systemctl enable ntpd'
bash run_command.sh 'systemctl start ntpd'

copy_file.sh ~/install/hosts /tmp
copy_file.sh ~/install/worker-0.sh /tmp

bash run_command.sh 'bash /tmp/worker-0.sh'
bash run_command.sh 'hostname'
bash run_command.sh 'hostname -f'
                        
bash run_command.sh 'cat /etc/sysconfig/network'
bash run_command.sh 'cat /etc/selinux/config'
bash run_command.sh 'umask 0022'

copy_file.sh ~/install/worker-1.sh /tmp
bash run_command.sh 'bash /tmp/worker-1.sh'
```

------------------------------------------------



##Start the Ambari yum install
```
wget -nv <Ambari-Repo-URL> -O /etc/yum.repos.d/ambari.repo
ambari-server setup
ambari-server start
```

