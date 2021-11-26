FROM alpine:3.14

LABEL APP="influxdb"
LABEL APP_REPOSITORY="https://dl.influxdata.com/influxdb/releases/"

ENV TIMEZONE Europe/Paris
ENV INFLUXDB_VERSION 1.7.11
ENV INFLUXDB_DB telegraf

# Installing packages
RUN apk add --no-cache su-exec bash curl

# Work path
# WORKDIR /scripts

# Downloading binaries
ADD https://dl.influxdata.com/influxdb/releases/influxdb-${INFLUXDB_VERSION}-static_linux_amd64.tar.gz ./

RUN addgroup influxdb && adduser -s /bin/false -G influxdb -S -D influxdb

# Installing binaries
RUN tar -C . -xzf influxdb-${INFLUXDB_VERSION}-static_linux_amd64.tar.gz && \
        chmod +x influxdb-*/* && \
        cp -a influxdb-*/* /usr/bin/ && \
        rm -rf *.tar.gz* influxdb-*/

VOLUME [ "/var/lib/influxdb" ]

EXPOSE 8086

ENV TELEGRAF_VERSION 1.19.3
ADD https://dl.influxdata.com/telegraf/releases/telegraf-${TELEGRAF_VERSION}_static_linux_amd64.tar.gz .
RUN mkdir -p /usr/src /etc/telegraf && \
    tar -C /usr/src -xzf telegraf-${TELEGRAF_VERSION}_static_linux_amd64.tar.gz && \
    mv /usr/src/telegraf*/etc/telegraf/telegraf.conf /etc/telegraf/ && \
    mkdir /etc/telegraf/telegraf.d && \
    cp -a /usr/src/telegraf*/usr/bin/telegraf /usr/bin/ && \
    rm -rf *.tar.gz* /usr/src #&& \
    # apk del .build-deps
    # addgroup -S telegraf && \
    # adduser -S telegraf -G telegraf && \
    # chown -R telegraf:telegraf /etc/telegraf

# RUN telegraf --input-filter cpu:mem:net:swap --output-filter influxdb:kafka config > /etc/telegraf/telegraf.conf; \
# 	sed -i 's*\# urls = \["http://127.0.0.1:8086"\]*urls = ["${INFLUX_URL}"]*g' /etc/telegraf/telegraf.conf


COPY influxdb.conf /etc/influxdb/influxdb.conf
COPY entrypoint.sh /entrypoint.sh
COPY init.sh /init-influxdb.sh

ENTRYPOINT ["/entrypoint.sh"]
CMD ["influxd"]

HEALTHCHECK --interval=30s --timeout=3s --start-period=5s CMD curl -f http://127.0.0.1:8086 || exit 1
