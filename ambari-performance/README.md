Edit the following file on the 

```
/var/lib/ambari-server/ambari-env.sh 

```

Adjust the -Xmx parameter and if views are being used, add or adjust -XX:MaxPermSize
```
export AMBARI_JVM_ARGS=$AMBARI_JVM_ARGS' -Xms2048m -Xmx8092m -XX:MaxPermSize=256m -Djava.security.auth.login.config=/etc/ambari-server/conf/krb5JAASLogin.conf -Djava.security.krb5.conf=/etc/krb5.conf -Djavax.security.auth.useSubjectCredsOnly=false’
```

