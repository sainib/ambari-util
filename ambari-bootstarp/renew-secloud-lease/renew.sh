#!/bin/sh
set +vx

curl http://hoover.field.hortonworks.com/cloudadmin/se/whitelist.php > /tmp/wh.html

stack_id=`grep birens /tmp/wh.html  | sed -r 's/tr/\n/g' | grep birens | awk -F'>' '{ print $3 }' | awk -F'<' '{ print $1 }'`

echo $stack_id
echo "Renewing stack for birens's stack id = $stack_id " > /tmp/birens-secloud-stack-renew.log

echo `curl http://hoover.field.hortonworks.com/cloudadmin/se/postpone_stack_deletion.php?id=${stack_id}&authorizer=` >> /tmp/birens-secloud-stack-renew.log

echo ""
echo ""
echo ""

mailx -s "Birens Stack Renewal on SE Cloud" bsaini@hortonworks.com <<EOM

The new scheduled deletion date is - `grep birens /tmp/wh.html  | sed -r 's/tr/\n/g' | grep birens | awk -F'>' '{ print $15 }' | awk -F'<' '{ print $1 }'`

Here is the log 

`cat /tmp/birens-secloud-stack-renew.log`

EOM

rm -rf /tmp/birens-secloud-stack-renew.log
