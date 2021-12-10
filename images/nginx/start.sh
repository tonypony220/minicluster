#!/bin/sh
cd /etc/nginx/

openssl req -x509 -nodes -days 365 -newkey rsa:1024 -keyout  /etc/nginx/localhost.key -out /etc/nginx/localhost.crt -subj '/CN=ftp.site.domain'

telegraf&
nginx # -g 'daemon off;'
wait -n 
exit $?
# tail -f /dev/null
