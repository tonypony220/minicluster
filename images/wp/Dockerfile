FROM alpine:3.14


RUN apk update && \
    apk add nginx && \
    # apk add php7-fpm && \
    # apk add php7-mysqli; \
    apk add gnupg nginx php7-fpm php7-common php7-iconv php7-json php7-gd \
    php7-curl php7-xml php7-mysqli php7-imap php7-pdo php7-pdo_mysql \
    php7-soap php7-xmlrpc php7-posix php7-mcrypt php7-gettext php7-ldap \
    php7-ctype php7-dom php7-session php7-mbstring \
	busybox-extras;  # telnet install
    # mkdir /run/nginx;


WORKDIR /var/www/html

ADD http://wordpress.org/latest.tar.gz . 
    
# ADD index.html .
ENV WORDPRESS_DB_USER root

RUN tar -xf latest.tar.gz -C .; \
	rm latest.tar.gz;

ADD nginx.conf /etc/nginx/http.d/default.conf
ADD start.sh .

EXPOSE 80
# CMD ["/bin/sh", "-c", "/usr/sbin/php-fpm7; exec nginx -g 'daemon off;';"]
CMD ["./start.sh"]

