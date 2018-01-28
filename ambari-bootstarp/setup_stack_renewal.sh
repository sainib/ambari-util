#!/bin/bash

crontab -l > /tmp/bsaini_cron_list
echo "0 11 * * * /root/ambari-util/ambari-bootstarp/renew-secloud-lease/renew.sh" >> /tmp/bsaini_cron_list
crontab /tmp/bsaini_cron_list
