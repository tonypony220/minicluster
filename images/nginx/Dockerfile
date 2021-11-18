FROM alpine:3.3


RUN apk update && \
    apk add nginx busybox-extras;
	# touch /var/log/nginx/access.log ; \
	# touch /var/log/nginx/error.log ; \
	# ln -sf 	  /dev/stdout /var/log/nginx/access.log \
    # && ln -sf /dev/stderr /var/log/nginx/error.log
    # mkdir /run/nginx;
	# https://serverfault.com/questions/599103/make-a-docker-application-write-to-stdout/634296#634296

# ADD start.sh .

EXPOSE 80
EXPOSE 443
# CMD ["/bin/sh", "-c", "/usr/sbin/php-fpm7; exec nginx -g 'daemon off;';"]
# CMD ["./start.sh"]
CMD ["nginx", "-g", "daemon off;"]

