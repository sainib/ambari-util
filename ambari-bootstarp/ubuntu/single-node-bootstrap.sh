#!/bin/sh

sudo su 

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

cat > /etc/sysctl.conf << EOF
# Sysctl for hadoop nodes
net.core.netdev_max_backlog = 4000
net.core.somaxconn = 4000
net.ipv4.ip_forward = 0
net.ipv4.conf.default.rp_filter = 1
net.ipv4.conf.default.accept_source_route = 0
net.ipv4.tcp_syncookies = 1
net.ipv4.tcp_sack = 0
net.ipv4.tcp_dsack = 0
net.ipv4.tcp_keepalive_time = 600
net.ipv4.tcp_keepalive_probes = 5
net.ipv4.tcp_keepalive_intvl = 15
net.ipv4.tcp_fin_timeout = 30
net.ipv4.tcp_rmem = 32768 436600 4193404
net.ipv4.tcp_wmem = 32768 436600 4193404
net.ipv4.tcp_retries2 = 10
net.ipv4.tcp_synack_retries = 3
net.ipv6.conf.all.disable_ipv6 = 1
net.ipv6.conf.default.disable_ipv6 = 1
net.ipv6.conf.lo.disable_ipv6 = 1
kernel.sysrq = 0
kernel.core_uses_pid = 1
kernel.msgmnb = 65536
kernel.msgmax = 65536
kernel.shmmax = 68719476736
kernel.shmall = 4294967296
vm.swappiness = 0
EOF

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

apt install libmysql-java


--INSTALL AMBARI 
--SETUP AMBARI

sudo ambari-server setup --jdbc-db=mysql --jdbc-driver=/usr/share/java/mysql.jar

