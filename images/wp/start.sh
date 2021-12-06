#!/bin/sh
cd wordpress
#false to true in debug statement
sed s/username_here/${WORDPRESS_DB_USER}/ wp-config-sample.php | \
sed s/database_name_here/${WORDPRESS_DB_NAME}/ | 				 \
sed s/password_here/${WORDPRESS_DB_PASSWORD}/ |  				 \
sed s/false/true/ | 							 				 \
sed s/localhost/${WORDPRESS_DB_HOST}/ > wp-config.php
# echo "<?php phpinfo() ?>" > index.php; \
# chmod -R 755 .;

wp core install --url=localhost:5050 --title=mysite --admin_user=bob --admin_password=1234 --admin_email=admin@ya.com --allow-root
wp user create hw h@m.com --allow-root
wp user create mob mob@m.com --allow-root

php-fpm7

#: adding user
# https://stackoverflow.com/questions/15872543/access-mysql-remote-database-from-command-line
# mysql -u$WORDPRESS_DB_USER -p$WORDPRESS_DB_PASSWORD -h${WORDPRESS_DB_HOST} << eof
# INSERT INTO ${WORDPRESS_DB_NAME}.`wp_users` (`ID`, `user_login`, `user_pass`, `user_nicename`, `user_email`, `user_status`, `display_name`) VALUES ('1000', 'tempuser', MD5('Str0ngPa55!'), 'tempuser', 'support@wpwhitesecurity.com', '0', 'Temp User');
# INSERT INTO ${WORDPRESS_DB_NAME}.`wp_usermeta` (`umeta_id`, `user_id`, `meta_key`, `meta_value`) VALUES (NULL, '1000', 'wp_capabilities', 'a:1:{s:13:"administrator";b:1;}');
# INSERT INTO ${WORDPRESS_DB_NAME}.`wp_usermeta` (`umeta_id`, `user_id`, `meta_key`, `meta_value`) VALUES (NULL, '1000', 'wp_user_level', '10');
# eof

telegraf&
nginx # -g 'daemon off;'
wait -n 
# tail -f /dev/null
