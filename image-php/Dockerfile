FROM alpine:3.14

RUN apk update && \
    apk add gnupg nginx php7-fpm php7-common php7-iconv php7-json php7-gd \
    php7-curl php7-xml php7-mysqli php7-imap php7-pdo php7-pdo_mysql \
    php7-soap php7-xmlrpc php7-posix php7-mcrypt php7-gettext php7-ldap \
    php7-ctype php7-dom php7-session php7-mbstring curl \

    && mkdir -p /var/www/html/ \
    && mkdir -p /run/nginx \
    && rm -f /var/cache/apk/*;

# Calculate download URL
ENV VERSION 5.1.1
ENV URL https://files.phpmyadmin.net/phpMyAdmin/${VERSION}/phpMyAdmin-${VERSION}-all-languages.tar.xz
# LABEL version=$VERSION

ADD $URL .
 RUN \
 	tar -xf phpMyAdmin-${VERSION}-all-languages.tar.xz -C /var/www/html --strip-components=1; \
 	rm phpMyAdmin-${VERSION}-all-languages.tar.xz; \
 	sed -i "s@define('CONFIG_DIR'.*@define('CONFIG_DIR', '/etc/phpmyadmin/');@" /var/www/html/libraries/vendor_config.php;

COPY config.inc.php /etc/phpmyadmin/config.inc.php
COPY php-fpm.conf 	/etc/php7/php-fpm.d/www.conf 
COPY php.ini 		/etc/php7/php.ini
COPY nginx.conf 	/etc/nginx/nginx.conf
# ENTRYPOINT ["nginx", "-g", "daemon off;", ";", "php-fpm7"]
# CMD ["php-fpm7"]
CMD ["tail", "-f", "/dev/null"]
