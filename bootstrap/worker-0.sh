#!/bin/sh
set -vx
chmod 700 ~/.ssh
chmod 600 ~/.ssh/authorized_keys
for path in redhat_transparent_hugepage transparent_hugepage; do
	for file in enabled defrag; do
		if test -f /sys/kernel/mm/${path}/${file}; then
			echo never > /sys/kernel/mm/${path}/${file}
		fi
	done
done
systemctl disable firewalld
systemctl stop firewalld
cat /tmp/hosts >> /etc/hosts
