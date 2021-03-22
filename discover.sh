#!/bin/bash

zabbix_hostname="envchk-server"

function sendData {
        zabbix_sender -c /etc/zabbix/zabbix_sender.conf -s $zabbix_hostname -k "$1" -o "$2" > /dev/null
        echo "$(date) $1 - $2"
}



# Discovery

data="{\"data\":["

for dev in /sys/bus/w1/devices/*/temperature; do
  name="$(echo "$dev" | sed -E 's;.*devices\/(.*)\/te.*;\1;')"
  line="{\"name\":\"$name\"}"
  data="$data$line,"
done

data="$(echo $data | sed 's/.$//')]}"

sendData "enviroment.temp.discover"  $data
