#!/bin/sh
cd /etc/nginx/

telegraf&
nginx # -g 'daemon off;'
wait -n 
exit $?
# tail -f /dev/null
