#!/bin/sh
link_target=$(echo $curl_target | awk -F/ '{print $3}')
linked=$(printenv | echo $(grep "\<$link_target_PORT_.*_TCP_PORT\>"))
if [ ! -z "$linked" ]; then
    link_port=$(echo $linked | cut -d'=' -f2)
    curl_target="$curl_target:$link_port"
fi
echo "$cron_interval /config/cronjob" > /mycron
echo "curl -f $curl_target" > /config/cronjob && chmod a+x /config/cronjob
crontab /mycron
crond -f
