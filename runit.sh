#!/bin/sh
link_target=$(echo $curl_target | awk -F/ '{print $3}')
linked=$(printenv | echo $(grep "\<$link_target_PORT_.*_TCP_PORT\>"))
if [ ! -z "$linked" ]; then
    link_port=$(echo $linked | cut -d'=' -f2)
    replace_target="$link_target:$link_port"
    curl_target=$(echo "$curl_target" | awk -F/ -v var="$replace_target" 'gsub($3,var,$0)')
    curl_target=$(echo "$curl_target" | awk -F/ -v var="$replace_target" 'gsub($3,var,$0)')
fi
echo "$cron_interval /config/cronjob" > /mycron
echo "curl -f $curl_target" > /config/cronjob && chmod a+x /config/cronjob
crontab /mycron
crond -f
