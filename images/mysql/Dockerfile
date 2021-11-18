FROM alpine:3.14

ENV MYSQL_ROOT_PASSWORD root
ENV MYSQL_DATABASE app
ENV MYSQL_USER app
ENV MYSQL_PASSWORD app
ENV MYSQL_USER_MONITORING monitoring
ENV MYSQL_PASSWORD_MONITORING monitoring

RUN apk update && apk add --no-cache mysql mysql-client 
RUN addgroup mysql mysql

COPY start.sh start.sh
# don't know wtf config not int mysql dir despite it is. 
# https://serverfault.com/questions/688513/cant-access-mysql-docker-container-from-the-host
COPY mariadb-server.cnf /etc/my.cnf.d/ 

VOLUME [ "/var/lib/mysql" ]

EXPOSE 3306

ENTRYPOINT [ "./start.sh" ]

