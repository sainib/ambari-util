#!/bin/bash

cat > /tmp/sysctl.props << EOF
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


for p in `cat /tmp/sysctl.props | awk -F'=' '{ print $1 }'`
do

echo "------ Checking $p"
grep $p /etc/sysctl.conf

done


rm /tmp/sysctl.props