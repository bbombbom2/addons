#ARG BUILD_FROM="alpine:latest"
#ARG BUILD_FROM
#FROM $BUILD_FROM
ARG BUILD_FROM=ghcr.io/hassio-addons/base/amd64:10.0.2
FROM alpine:3.13 AS builder
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

RUN apk add --no-cache --virtual .build-deps \
        abuild linux-headers \
        curl-dev libconfig-dev gcc make \
        musl-dev mosquitto-dev wget \
    && apk add --no-cache \
        libcurl libconfig-dev mosquitto-dev lmdb-dev libsodium-dev lua5.2-dev \
    && mkdir -p /usr/local/source \
    && cd /usr/local/source \
    && mv /recorder.tar.gz ./ \
    && tar xzf recorder.tar.gz \
    && cd recorder-$VERSION \
    && mv /config.mk ./ \
    && make \
    && make install \
    && chmod 755 /entrypoint.sh \
    && rm -rf /usr/local/source \
    && chmod 755 /usr/local/sbin/recorder-health.sh \
    && apk del .build-deps
RUN apk add --no-cache \
	curl jq

VOLUME ["/store", "/config"]

HEALTHCHECK CMD /usr/local/sbin/recorder-health.sh

ENTRYPOINT ["/entrypoint.sh"]

#COPY config.mk /tmp/recorder-0.8.7/

#RUN cd /tmp/recorder-0.8.7/ && \
#    make

#FROM $BUILD_FROM

#ENV LANG C.UTF-8

#RUN apk -U --no-cache upgrade && \
#    apk --no-cache add jq && \
#    apk --no-cache add libcurl lmdb libconfig libsodium mosquitto-libs

#EXPOSE 8083

#COPY --from=builder /tmp/recorder-0.8.7/ocat /usr/sbin/
#COPY --from=builder /tmp/recorder-0.8.7/ot-recorder /usr/sbin/
#COPY --from=builder /tmp/recorder-0.8.7/docroot /var/spool/owntracks/recorder/htdocs
#COPY run.sh /
#RUN chmod a+x /run.sh

#CMD [ "/run.sh" ]
