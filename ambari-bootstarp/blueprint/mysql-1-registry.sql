##### 
## RUN ON SAM HOST 
####



yum -y install mysql-connector-java.noarch

yum -y localinstall \
https://dev.mysql.com/get/mysql57-community-release-el7-8.noarch.rpm

yum -y install mysql-community-server

#~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
## Edit /etc/my.cnf and add the line below 
bind-address = 0.0.0.0
#~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

systemctl start mysqld.service

grep 'A temporary password is generated for root@localhost' \
/var/log/mysqld.log |tail -1

/usr/bin/mysql_secure_installation
Change the root user password.. and use that as dba admin 

mysql -u root -p


CREATE USER 'registry'@'%' IDENTIFIED BY '9oNio)ex1ndL'; 

CREATE DATABASE registry DEFAULT CHARACTER SET utf8; 

CREATE USER 'registry'@'127.0.0.1' IDENTIFIED BY '9oNio)ex1ndL'; 

CREATE USER 'registry'@'birens0' IDENTIFIED BY '9oNio)ex1ndL'; 

CREATE USER 'registry'@'birens0.field.hortonworks.com' IDENTIFIED BY '9oNio)ex1ndL'; 

CREATE USER 'registry'@'localhost' IDENTIFIED BY '9oNio)ex1ndL'; 

GRANT ALL PRIVILEGES ON *.* TO 'registry'@'%' WITH GRANT OPTION; 

GRANT ALL PRIVILEGES ON *.* TO 'registry'@'birens0' WITH GRANT OPTION; 

GRANT ALL PRIVILEGES ON *.* TO 'registry'@'birens0.field.hortonworks.com' WITH GRANT OPTION; 

GRANT ALL PRIVILEGES ON *.* TO 'registry'@'localhost' WITH GRANT OPTION; 

CREATE USER 'root'@'birens0.field.hortonworks.com' IDENTIFIED BY '9oNio)ex1ndL'; 

GRANT ALL PRIVILEGES ON *.* TO 'root'@'birens0.field.hortonworks.com' WITH GRANT OPTION;

#-------------------------

CREATE USER 'streamline'@'%' IDENTIFIED BY '9oNio)ex1ndL'; 

CREATE DATABASE streamline DEFAULT CHARACTER SET utf8; 

CREATE USER 'streamline'@'127.0.0.1' IDENTIFIED BY '9oNio)ex1ndL'; 

CREATE USER 'streamline'@'birens0' IDENTIFIED BY '9oNio)ex1ndL'; 

CREATE USER 'streamline'@'birens0.field.hortonworks.com' IDENTIFIED BY '9oNio)ex1ndL'; 

CREATE USER 'streamline'@'localhost' IDENTIFIED BY '9oNio)ex1ndL'; 

GRANT ALL PRIVILEGES ON *.* TO 'streamline'@'%' WITH GRANT OPTION; 

GRANT ALL PRIVILEGES ON *.* TO 'streamline'@'birens0' WITH GRANT OPTION; 

GRANT ALL PRIVILEGES ON *.* TO 'streamline'@'birens0.field.hortonworks.com' WITH GRANT OPTION; 

GRANT ALL PRIVILEGES ON *.* TO 'streamline'@'localhost' WITH GRANT OPTION; 

CREATE USER 'root'@'birens0.field.hortonworks.com' IDENTIFIED BY '9oNio)ex1ndL'; 

GRANT ALL PRIVILEGES ON *.* TO 'root'@'birens0.field.hortonworks.com' WITH GRANT OPTION;


#-------------------------

commit;

FLUSH PRIVILEGES;
