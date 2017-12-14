 #!/bin/sh
# createuser.sh
HOST=${1}:8080
USERTOTAL=${2:-20}

##### create group
echo "......... creating group"
curl -iv -u admin:admin -H "X-Requested-By: ambari" -X POST -d "{\"Groups/group_name\":\"labusers\"}" "http://$HOST/api/v1/groups";;

#####  create student users and add to group
CURRENTUSER=0
while [ $CURRENTUSER -le $USERTOTAL ]
do
    echo ".......... creating user $CURRENTUSER"
    curl -iv -u admin:admin -H "X-Requested-By: ambari" -X POST -d "{\"Users/user_name\":\"user$CURRENTUSER\", \"Users/password\":\"user$CURRENTUSER-pass\", \"Users/active\":\"true\", \"Users/admin\":\"false\"}" "http://$HOST/api/v1/users";;
    
    echo ".......... adding user to group"
    curl -iv -u admin:admin -H "X-Requested-By: ambari" -X POST -d "[{\"MemberInfo/user_name\":\"user$CURRENTUSER\",\"MemberInfo/group_name\":\"labusers\"}]" "http://$HOST/api/v1/groups/labusers/members";;
    
    echo ".......... creating dir  /user/user$CURRENTUSER"
    su hdfs -c "hdfs dfs -mkdir /user/user$CURRENTUSER"
    su hdfs -c  "hdfs dfs -chown -R user$CURRENTUSER:hdfs /user/user$CURRENTUSER"

    echo  ".......... creating linux user"
    useradd -m user$CURRENTUSER
    echo -e "hadoop$CURRENTUSER\nhadoop$CURRENTUSER\n" | passwd user$CURRENTUSER

    CURRENTUSER=$(( CURRENTUSER+1 ))
done

echo "..... done"
