#ARG BUILD_FROM="alpine:latest"
FROM alpine
LABEL version="1.0" description="OwnTracks Recorder for Hass"
LABEL authors="Zooil Yang <me@zooil.com>"
MAINTAINER zooil <me@zooil.com>

ENV LANG C.UTF-8

# build with `docker build --build-arg recorder_version=x.y.z '
ARG recorder_version=0.8.3

COPY entrypoint.sh /entrypoint.sh
COPY config.mk /config.mk
COPY recorder.conf /etc/default/recorder.conf
COPY recorder-health.sh /usr/local/sbin/recorder-health.sh
COPY recorder.tar.gz /

ENV VERSION=$recorder_version

RUN apk add --no-cache --virtual .build-deps \
curl-dev libconfig-dev make \
gcc musl-dev mosquitto-dev wget \

#RUN apk add --no-cache \
#libcurl libconfig-dev mosquitto-dev lmdb-dev libsodium-dev lua5.2-dev \

#RUN mkdir -p /usr/local/source \
#RUN cd /usr/local/source \
#RUN mv /recorder.tar.gz ./ \
#RUN tar xzf recorder.tar.gz \
#RUN cd recorder-$VERSION \
#RUN mv /config.mk ./ \
#RUN make \
#RUN make install \
#RUN cd / \
#RUN chmod 755 /entrypoint.sh \
#RUN rm -rf /usr/local/source \
#RUN chmod 755 /usr/local/sbin/recorder-health.sh \
#RUN  apk del .build-deps
#RUN apk add --no-cache \
#curl jq

#VOLUME ["/store", "/config"]

#COPY recorder.conf /config/recorder.conf

#HEALTHCHECK CMD /usr/local/sbin/recorder-health.sh

#EXPOSE 8083

#ENTRYPOINT ["/entrypoint.sh"]
