#!/bin/sh
link_target=$(echo $curl_target | awk -F/ '{print $3}')
linked=$(printenv | grep "\<$link_target_PORT_.*_TCP_PORT\>" | head -n 1)
curl_options="-f"
if [ ! -z "$linked" ]; then
    link_port=$(echo $linked | cut -d'=' -f2)
    curl_target=$(echo "$curl_target" | awk -F/ -v var="$link_target:$link_port" 'gsub($3,var,$0)')
fi
echo "$cron_interval /config/cronjob" > /mycron
if [ ! -z "$silent" ] && [ "$silent" == "true" ]; then
	curl_options="${curl_options}s"
fi
echo "curl $curl_options $curl_target" > /config/cronjob && chmod a+x /config/cronjob
crontab /mycron
crond -f
