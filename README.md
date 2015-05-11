# docker-cron-curl
Simple cron service that curls a target url. Can be either a fully qualified domain or a linked container.

# Use

This example links a python web app and cURLs it automatically detecting which port is exposed.

```docker run --name cron_curl --link sentry:sentry -e curl_target=http://sentry -e cron_interval="* * * * *" cron-curl```

This example cURLs a fully qualified domain every 5 minutes

```docker run --name cron_curl -e curl_target=http://www.google.com -e cron_interval="*/5 * * * *" cron-curl```