# Allowing Remote connection for MySQl

1 - Edit /etc/my.cnf to add bind-address=0.0.0.0 within mysqld section of the file 

```
Default options are read from the following files in the given order:
/etc/my.cnf /etc/mysql/my.cnf /usr/etc/my.cnf ~/.my.cnf
```

1a - Restart MySQl service if you have to edit the my.cnf file. 

```
service mysqld restart
```

2 - Make sure that user is setup to be able to make remote connections to the mysql server

```
GRANT ALL ON dbname.* TO dbuser@remote_node_name_or_ip IDENTIFIED BY 'dbuserpassword';
```

3 - Verify the connectivity
