#!/bin/sh

# Load Default recorder.conf if not available
if [!-f /config/recorder.conf ]; then
cp /etc/default/recorder.conf /config/recorder.conf
fi

a='cat /config/recorder.conf'
ot-recorder --initialize
ot-recorder $a

#while true; do echo "still live"; sleep 100; done
