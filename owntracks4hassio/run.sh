#!/bin/sh

set -e

CONFIG_PATH=/data/options.json

TOPICS=$(jq --raw-output ".topics" $CONFIG_PATH)
HOST=$(jq --raw-output ".host" $CONFIG_PATH)
PORT=$(jq --raw-output ".port" $CONFIG_PATH)
USER=$(jq --raw-output ".user" $CONFIG_PATH)
PASS=$(jq --raw-output ".pass" $CONFIG_PATH)
QOS=$(jq --raw-output ".qos" $CONFIG_PATH)

echo "
OTR_STORAGEDIR = \"/share/ot-recorder\"
OTR_TOPICS = \"$TOPICS\"
OTR_HOST = \"$HOST\"
OTR_PORT = $PORT
OTR_USER = \"$USER\"
OTR_PASS = \"$PASS\"
OTR_QOS = $QOS 
" > /etc/ot-recorder.cfg

if [ ! -d /share/ot-recorder ] ; then 
  mkdir /share/ot-recorder
fi

if [ ! -f /share/ot-recorder/ghash/data.mdb ] ; then
  /usr/sbin/ot-recorder --initialize
fi

/usr/sbin/ot-recorder --http-host 0.0.0.0
