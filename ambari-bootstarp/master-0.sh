#!/bin/sh

yum -y update
yum install -y -q curl ntp openssl python zlib wget unzip openssh-clients
echo ""
echo "1 - Creating SSH Key on Master"

ssh-keygen

cd ~/.ssh
cat id_rsa.pub >> authorized_keys

cd ~/.ssh

echo ""
echo ""
cat id_rsa.pub
echo ""
echo ""
