#ARG BUILD_FROM="alpine:latest"
ARG BUILD_FROM
FROM $BUILD_FROM
LABEL version="1.0" description="OwnTracks Recorder for Hass"
LABEL authors="Zooil Yang <me@zooil.com>"
MAINTAINER zooil <me@zooil.com>

ENV LANG C.UTF-8

# build with `docker build --build-arg recorder_version=x.y.z '
ARG recorder_version=0.8.3

COPY makeconf.sh entrypoint.sh recorder.tar.gz config.mk / 
COPY recorder.conf /etc/default/recorder.conf
COPY recorder-health.sh /usr/local/sbin/recorder-health.sh

ENV VERSION=$recorder_version

RUN apk add g++ && apk add make build-essential
#RUN apk add --no-cache --virtual .build-deps
#RUN apk add curl-dev libconfig-dev make
#RUN apk add apk add --no-cache
#RUN apk add libcurl libconfig-dev mosquitto-dev lmdb-dev libsodium-dev lua5.2-dev
#RUN mkdir -p /usr/local/source
#RUN cd /usr/local/source
#RUN mv /recorder.tar.gz ./
#RUN tar xzf recorder.tar.gz
#RUN cd recorder-$VERSION
#RUN mv /config.mk ./
#RUN make
#RUN make install
#RUN cd /
#RUN chmod 755 /entrypoint.sh
#RUN rm -rf /usr/local/source
#RUN chmod 755 /usr/local/sbin/recorder-health.sh
#RUN apk del .build-deps
#RUN apk add --no-cache \
#	curl jq

VOLUME ["/store", "/config"]

HEALTHCHECK CMD /usr/local/sbin/recorder-health.sh

ENTRYPOINT ["/entrypoint.sh"]
