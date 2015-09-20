#!/bin/bash 


wait_time=10

echo "Checking Mount"
echo "---------------------------------------------"
echo "sudo mount 2>/dev/null | grep -v \#"
sudo mount 2>/dev/null | grep -v \#
echo ""
echo ""

sleep ${wait_time}

echo "Checking limits.conf"
echo "---------------------------------------------"
echo "sudo cat /etc/security/limits.conf  2>/dev/null | grep -v \#"
sudo cat /etc/security/limits.conf  2>/dev/null | grep -v \#
echo ""
echo ""

sleep ${wait_time}


echo "Checking sysctl.conf"
echo "---------------------------------------------"
echo "sudo cat /etc/sysctl.conf  2>/dev/null | grep -v \#"
sudo cat /etc/sysctl.conf  2>/dev/null | grep -v \#
echo ""
echo ""

sleep ${wait_time}

echo "Checking Services"
echo "---------------------------------------------"
echo "sudo chkconfig --list | grep ntp  2>/dev/null | grep -v \#"
sudo chkconfig --list | grep ntp  2>/dev/null | grep -v \#
echo "sudo chkconfig --list | grep iptable  2>/dev/null | grep -v \#"
sudo chkconfig --list | grep iptable  2>/dev/null | grep -v \#
echo ""
echo ""

sleep ${wait_time}


echo "Checking rc.local"
echo "---------------------------------------------"
echo "sudo cat /etc/rc.local 2>/dev/null | grep -v \#"
sudo cat /etc/rc.local 2>/dev/null | grep -v \#
echo ""
echo ""

sleep ${wait_time}

echo "Core HDP / Hadoop Users"
echo "---------------------------------------------"
echo ""
echo "HDP `grep -c HDP /etc/passwd`"
echo "oozie `grep -c oozie /etc/passwd`"
echo "hive `grep -c hive /etc/passwd`"
echo "ambari-qa `grep -c ambari-qa /etc/passwd`"
echo "flume `grep -c flume /etc/passwd`"
echo "hdfs `grep -c hdfs /etc/passwd`"
echo "knox `grep -c knox /etc/passwd`"
echo "storm `grep -c storm /etc/passwd`"
echo "spark `grep -c spark /etc/passwd`"
echo "mapred `grep -c mapred /etc/passwd`"
echo "hbase `grep -c hbase /etc/passwd`"
echo "tez `grep -c tez /etc/passwd`"
echo "zookeeper `grep -c zookeeper /etc/passwd`"
echo "kafka `grep -c kafka /etc/passwd`"
echo "falcon `grep -c falcon /etc/passwd`"
echo "sqoop `grep -c sqoop /etc/passwd`"
echo "yarn `grep -c yarn /etc/passwd`"
echo "hcat `grep -c hcat /etc/passwd`"
echo "ams `grep -c ams /etc/passwd`"
echo "atlas `grep -c atlas /etc/passwd`"
echo "solr `grep -c solr /etc/passwd`"
echo "hue `grep -c hue /etc/passwd`"
echo "apache `grep -c apache /etc/passwd`"
echo "kms `grep -c kms /etc/passwd`"
echo "ranger `grep -c ranger /etc/passwd`"
echo "xapolicymgr `grep -c xapolicymgr /etc/passwd`"
echo ""
echo ""

sleep ${wait_time}


echo "Checking HDP / Hadoop Supporting Users"
echo "---------------------------------------------"
echo ""

echo "postgres `grep -c postgres /etc/passwd`"
echo "mysql `grep -c mysql /etc/passwd`"
echo "nfsnobody `grep -c nfsnobody /etc/passwd`"


echo ""
echo ""

sleep ${wait_time}


echo "Checking Commands"
echo "---------------------------------------------"
echo ""
command -v "hdfs" 
command -v "hadoop"
echo ""
echo ""

sleep ${wait_time}


echo "Checking background processes for resource consumptions"
echo "---------------------------------------------"
echo "top -n 1 -b -o +%CPU | head -20"
top -n 1 -b -o +%CPU | head -20
echo "---------------------------------------------"
echo "top -n 1 -b -o +%MEM | head -20"
top -n 1 -b -o +%MEM | head -20
echo ""

sleep ${wait_time}


echo "Checking Libraries"
echo "---------------------------------------------"
echo "rpm -qa | grep mapr "
rpm -qa | grep mapr 
echo "---------------------------------------------"
echo "ls -ltra /opt/mapr"
ls -ltra /opt/mapr
echo "---------------------------------------------"
echo "ls -ltra /opt/cores"
ls -ltra /opt/cores
echo "---------------------------------------------"
echo "ls -ltra /usr"
ls -ltra /usr
echo "---------------------------------------------"
echo ""

sleep ${wait_time}


echo "Checking Done"
echo "---------------------------------------------"
echo ""
