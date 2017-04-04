/var/lib/ambari-server/ambari-env.sh , change the red part from 12288 to 8092 (yes, reduce) & add the blue part 
 
export AMBARI_JVM_ARGS=$AMBARI_JVM_ARGS' -Xms2048m -Xmx8092m -XX:MaxPermSize=256m -Djava.security.auth.login.config=/etc/ambari-server/conf/krb5JAASLogin.conf -Djava.security.krb5.conf=/etc/krb5.conf -Djavax.security.auth.useSubjectCredsOnly=false’


