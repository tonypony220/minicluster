FROM alpine:3.12
# https://github.com/delfer/docker-alpine-ftp-server
# https://mikestechblog.com/vsftpd-refusing-to-run-with-writable-root-inside-chroot/
RUN apk --no-cache add vsftpd openssl # vim lftp su-exec
#SSL_connect: sslv3 alert handshake failure

COPY start_vsftpd.sh /bin/start_vsftpd.sh
COPY vsftpd.conf /etc/vsftpd/vsftpd.conf
COPY lftp.ssl.commands /
COPY sc.bash /

EXPOSE 21 21000-21010
VOLUME /ftp/ftp

ENV TELEGRAF_VERSION 1.19.3
ADD https://dl.influxdata.com/telegraf/releases/telegraf-${TELEGRAF_VERSION}_static_linux_amd64.tar.gz .
RUN mkdir -p /usr/src /etc/telegraf && \
    tar -C /usr/src -xzf telegraf-${TELEGRAF_VERSION}_static_linux_amd64.tar.gz && \
    mv /usr/src/telegraf*/etc/telegraf/telegraf.conf /etc/telegraf/ && \
    mkdir /etc/telegraf/telegraf.d && \
    cp -a /usr/src/telegraf*/usr/bin/telegraf /usr/bin/ && \
    rm -rf *.tar.gz* /usr/src

RUN telegraf --input-filter cpu:mem:net --output-filter influxdb config > /etc/telegraf/telegraf.conf; \
	sed -i 's*\# urls = \["http://127.0.0.1:8086"\]*urls = ["http://${INFLUX_URL}:8086"]*g' /etc/telegraf/telegraf.conf

#STOPSIGNAL SIGKILL

HEALTHCHECK --interval=30s --timeout=3s --start-period=5s CMD exit 1

ENTRYPOINT ["/bin/start_vsftpd.sh"]

#ftp-578dcf968f-rhghb
