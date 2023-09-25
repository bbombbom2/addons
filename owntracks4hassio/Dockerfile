# we use a different image for building
# see https://wiki.alpinelinux.org/wiki/Release_Notes_for_Alpine_3.14.0#faccessat2

ARG BUILD_FROM=ghcr.io/hassio-addons/base/amd64:10.0.2
FROM alpine:3.13 AS builder

ENV LANG C.UTF-8

RUN apk add --no-cache \
    abuild linux-headers musl-dev mosquitto-dev \
    lmdb-dev curl-dev libconfig-dev gcc make libsodium-dev && \
    wget -q https://github.com/owntracks/recorder/archive/0.8.7.tar.gz -O - | tar xvzC /tmp

COPY config.mk /tmp/recorder-0.8.7/

RUN cd /tmp/recorder-0.8.7/ && \
    make

FROM $BUILD_FROM

ENV LANG C.UTF-8

RUN apk -U --no-cache upgrade && \
    apk --no-cache add jq && \
    apk --no-cache add libcurl lmdb libconfig libsodium mosquitto-libs

EXPOSE 8083

COPY --from=builder /tmp/recorder-0.8.7/ocat /usr/sbin/
COPY --from=builder /tmp/recorder-0.8.7/ot-recorder /usr/sbin/
COPY --from=builder /tmp/recorder-0.8.7/docroot /var/spool/owntracks/recorder/htdocs
COPY run.sh /
RUN chmod a+x /run.sh

CMD [ "/run.sh" ]
