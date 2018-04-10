#/bin/sh

bash run_command.sh 'ifconfig'  | grep broadcast | grep netmask
bash run_command.sh 'yum -y update'
bash run_command.sh 'yum install -y -q curl ntp openssl python zlib wget unzip openssh-clients'
bash run_command.sh 'systemctl is-enabled ntpd'
bash run_command.sh 'systemctl enable ntpd'
bash run_command.sh 'systemctl start ntpd'

bash copy_file.sh ~/install/hosts /tmp
bash copy_file.sh ~/install/worker-0.sh /tmp
bash copy_file.sh ~/install/profile /tmp

bash run_command.sh 'bash /tmp/worker-0.sh'
bash run_command.sh 'umask 0022'
bash run_command.sh 'cat /tmp/profile >> ~/.profile'

bash copy_file.sh ~/install/worker-1.sh /tmp
bash run_command.sh 'bash /tmp/worker-1.sh'

#Lets check the configs to confirm updates
bash run_command.sh 'hostname'
bash run_command.sh 'hostname -f'
bash run_command.sh 'cat /etc/sysconfig/network'
bash run_command.sh 'cat /etc/selinux/config'

#Additional stuff for python libs -- Needed for pyspark and data science stuff.. 
bash run_command.sh 'yum install -y -q epel-release'
bash run_command.sh 'yum install -y -q python-pip'
bash run_command.sh 'pip install --upgrade pip'
bash run_command.sh 'pip install numpy'

bash run_command.sh "yum-complete-transaction -y"

bash run_command.sh 'wget http://repo.mysql.com/mysql-community-release-el7-5.noarch.rpm'
bash run_command.sh 'sudo rpm -ivh mysql-community-release-el7-5.noarch.rpm'
bash run_command.sh 'yum update -y'
