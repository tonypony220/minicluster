#!/bin/sh
cd wordpress
#false to true in debug statement
sed s/username_here/${WORDPRESS_DB_USER}/ wp-config-sample.php | \
sed s/database_name_here/${WORDPRESS_DB_NAME}/ | \
sed s/password_here/${WORDPRESS_DB_PASSWORD}/ | \
sed s/false/true/ | \
sed s/localhost/${WORDPRESS_DB_HOST}/ > wp-config.php
# echo "<?php phpinfo() ?>" > index.php; \
# chmod -R 755 .;

php-fpm7
nginx -g 'daemon off;'
# tail -f /dev/null
