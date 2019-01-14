#!/bin/sh

sudo su 

apt install -y git
cd
git clone https://github.com/sainib/ambari-util.git
cd /root/ambari-util/ambari-bootstarp/ubuntu
bash single-node-bootstrap.sh

apt update
apt install -y curl ntp openssl python zlib1g-dev wget unzip openssh-client ntp

ssh-keygen
cd ~/.ssh
cat id_rsa.pub >> authorized_keys

#timedatectl set-timezone America/New_York
#timedatectl set-ntp on


timedatectl set-ntp no
timedatectl
ntpq -p

umask 0022
echo never > /sys/kernel/mm/transparent_hugepage/enabled

ufw status
#ufw disable

apt install policycoreutils

sestatus
#setenforce 0

echo > /etc/security/limits.conf << EOF
* - nofile 32768
* - nproc 65536
EOF


#vi /etc/rc.local

#		echo 512 > /sys/block/xvda/queue/nr_request
#		echo 254 > /sys/block/xvda/device/queue_depth
#		/sbin/blockdev --setra 1024 /dev/xvda
#		exit 0
#


if test -f /sys/kernel/mm/transparent_hugepage/enabled; then
   echo never > /sys/kernel/mm/transparent_hugepage/enabled
fi
if test -f /sys/kernel/mm/transparent_hugepage/defrag; then
   echo never > /sys/kernel/mm/transparent_hugepage/defrag
fi


apt install -y -q python-pip
pip install --upgrade pip
pip install numpy

