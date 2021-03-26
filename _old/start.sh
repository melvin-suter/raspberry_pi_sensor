#!/bin/bash

/opt/temp_sender/discover.sh

# Send Data
while true ; do
  for dev in /sys/bus/w1/devices/*/temperature; do
    name="$(echo "$dev" | sed -E 's;.*devices\/(.*)\/te.*;\1;')"
    /opt/temp_sender/send.sh $name
  done
  sleep 5
done
