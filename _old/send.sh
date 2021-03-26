#!/bin/bash

zabbix_hostname="envchk-server"

function sendData {
        zabbix_sender -c /etc/zabbix/zabbix_sender.conf -s $zabbix_hostname -k "$1" -o "$2" > /dev/null
        echo "$(date) $1 - $2"
}



# Discovery

current_temp=$(cat /sys/bus/w1/devices/$1/temperature)
current_temp_round=$(($current_temp / 1000 ))
current_temp_decimal=$(( $current_temp - $(($current_temp_round * 1000)) ))
sendData "enviroment.temp[$1]" "$current_temp_round.$current_temp_decimal"
