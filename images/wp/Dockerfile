FROM alpine:3.12
# !! nslookup (github) not working 


RUN apk update && 		   \
    apk add nginx curl mysql-client &&  \
    # apk add php7-fpm &&  \
    # apk add php7-mysqli; \
    apk add gnupg nginx php7-fpm php7-common php7-iconv php7-json php7-gd \
    php7-curl php7-xml php7-mysqli php7-imap php7-pdo php7-pdo_mysql \
    php7-soap php7-xmlrpc php7-posix php7-mcrypt php7-gettext php7-ldap \
    php7-ctype php7-dom php7-session php7-mbstring \
	busybox-extras;  # telnet install
    # mkdir /run/nginx;

ENV TELEGRAF_VERSION 1.19.3
ADD https://dl.influxdata.com/telegraf/releases/telegraf-${TELEGRAF_VERSION}_static_linux_amd64.tar.gz .
RUN mkdir -p /usr/src /etc/telegraf && \
    tar -C /usr/src -xzf telegraf-${TELEGRAF_VERSION}_static_linux_amd64.tar.gz && \
    mv /usr/src/telegraf*/etc/telegraf/telegraf.conf /etc/telegraf/ && \
    mkdir /etc/telegraf/telegraf.d && \
    cp -a /usr/src/telegraf*/usr/bin/telegraf /usr/bin/ && \
    rm -rf *.tar.gz* /usr/src

RUN telegraf --input-filter cpu:mem:net:nginx --output-filter influxdb config > /etc/telegraf/telegraf.conf; \
	sed -i 's*\# urls = \["http://127.0.0.1:8086"\]*urls = ["http://${INFLUX_URL}:8086"]*g' /etc/telegraf/telegraf.conf

WORKDIR /var/www/html

ADD http://wordpress.org/latest.tar.gz . 
    
# ADD index.html .
ENV WORDPRESS_DB_USER root

RUN tar -xf latest.tar.gz -C .; \
	rm latest.tar.gz;

RUN curl -O https://raw.githubusercontent.com/wp-cli/builds/gh-pages/phar/wp-cli.phar && \
	chmod +x wp-cli.phar && \
	mv wp-cli.phar /usr/local/bin/wp-cli

ADD nginx.conf /etc/nginx/http.d/default.conf
ADD start.sh .

EXPOSE 80
# CMD ["/bin/sh", "-c", "/usr/sbin/php-fpm7; exec nginx -g 'daemon off;';"]
CMD ["./start.sh"]

HEALTHCHECK --interval=30s --timeout=3s --start-period=5s CMD curl -f http://127.0.0.1/ || exit 1
