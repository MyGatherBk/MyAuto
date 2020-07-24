#!/bin/bash
# Modified by : _MyGatherBK_
#PROXY : _DEBIAN 10
# ==================================================
# Initializing Var

# IP=$(ip addr | grep 'inet' | grep -v inet6 | grep -vE '127\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}' | grep -o -E '[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}' | head -1)
# if [[ "$IP" = "" ]]; then
IP=$(wget -4qO- "http://whatismyip.akamai.com/")
# fi
# Install Squid3
cd
apt-get -y install squid
wget -O /etc/squid/squid.conf "https://raw.githubusercontent.com/MyGatherBk/MyAuto/master/squid.conf"
sed -i $IP /etc/squid/squid.conf;
systemctl squid restart
