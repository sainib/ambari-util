#!/bin/sh

yum -y update
yum install -y -q curl ntp openssl python zlib wget unzip openssh-clients

cd 
mkdir install 
cd ~/install
cp /root/ambari-util/ambari-bootstarp/* . 
##---Execute the following steps manually -----
unzip tools.zip
cp ./tools/* .
rm -rf __MACOSX/ tools

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
