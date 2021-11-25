#!/bin/sh
telegraf&
nginx # -g 'daemon off;'
wait -n 
exit $?
# tail -f /dev/null
