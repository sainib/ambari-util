# Steps to quickly bootstrap Openstack based cluster

# Overview 

## Run the following on master
------------------------------------------------
```
git clone https://github.com/sainib/ambari-util.git
```
-- Rearrange the files and directories ~ TBD 

-- run following commands manually on ambari server - 
```
cd ~/install
vi Hostdetail.txt
#Add all host names in the file 

vi ~/install/hosts
#Add all host enteries 
```

-- run master-0.sh on master 
```
bash master-0.sh
```

------------------------------------------------
## Run the following on all worker nodes

```
#copy and paste the id_rsa.pub content from other server into the authorized_keys on worker
vi ~/.ssh/authorized_keys
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

