FROM ubuntu:14.04
MAINTAINER ssokol@softserveinc.com

ENV TS_VERSION=${TS_VERSION:-6.1.1}
ENV TS_PKG=${TS_PKG:-trafficserver-$TS_VERSION.tar.bz2}
ENV TS_URL=${TS_URL:-http://www-us.apache.org/dist/trafficserver/$TS_PKG}
ENV TS_PATH=${TS_PATH:-/opt/trafficserver}

RUN apt-get update \
    && apt-get upgrade -y \
    && apt-get install -y wget build-essential locales bzip2 libssl-dev libxml2-dev libpcre3-dev tcl-dev libboost-dev \
    && mkdir -p $TS_PATH \
    && wget $TS_URL -O /tmp/$TS_PKG && tar -xjf /tmp/$TS_PKG -C /tmp && cd /tmp/trafficserver-$TS_VERSION \
    && ./configure --prefix=$TS_PATH \
    && make && make install \
    && mv $TS_PATH/etc/trafficserver /etc/trafficserver \
    && ln -sf /etc/trafficserver $TS_PATH/etc/trafficserver \
    && rm -rf /tmp/* && apt-get purge -y bzip2 build-essential

COPY config/* /etc/trafficserver

EXPOSE 8080

CMD ["/opt/trafficserver/bin/traffic_server"]

