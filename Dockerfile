FROM ubuntu:18.04
LABEL maintainer="tech.herry@gmail.com"

ENV TS_VERSION=${TS_VERSION:-8.0.1}
ENV TS_PKG=${TS_PKG:-trafficserver-$TS_VERSION.tar.bz2}
ENV TS_URL=${TS_URL:-http://mirrors.gigenet.com/apache/trafficserver/$TS_PKG}
ENV TS_PATH=${TS_PATH:-/opt/trafficserver}
ENV PATH=$TS_PATH/bin:$PATH
RUN set -x \
    && DEBIAN_FRONTEND=noninteractive apt-get update \
    && DEBIAN_FRONTEND=noninteractive apt-get install -y \
        curl \
        build-essential \
        netcat \
        locales \
        bzip2 \
        libssl-dev \
        libxml2-dev \
        libpcre3-dev \
        tcl \
        tcl-dev \
        libboost-dev \
        supervisor \
    && mkdir -p $TS_PATH \
    && mkdir /tmp/ts \
    && cd /tmp/ts \
    && curl -L $TS_URL | tar -xj --strip-components 1 \
    && ./configure --prefix=$TS_PATH \
    && make && make install \
    && mv $TS_PATH/etc/trafficserver /etc/trafficserver \
    && ln -sf /etc/trafficserver $TS_PATH/etc/trafficserver \
    && apt-get purge --auto-remove -y \
        bzip2 \
        build-essential \
        libssl-dev \
        libxml2-dev \
        libpcre3-dev \
        tcl-dev \
        libboost-dev \
    && apt-get clean \
    && rm -rf /tmp/*

COPY config/* /etc/trafficserver/
COPY supervisord.conf /etc/supervisor/conf.d/supervisord.conf
COPY access_log_out.sh /opt/access_log_out.sh
COPY docker-entrypoint.sh /docker-entrypoint.sh

RUN chmod 0755 /docker-entrypoint.sh /opt/access_log_out.sh && chown -R nobody:nogroup /etc/trafficserver

EXPOSE 8080 8083

ENTRYPOINT ["/docker-entrypoint.sh"]

CMD ["/usr/bin/supervisord"]
