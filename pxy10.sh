#!/bin/bash
# Modified by : _MyGatherBK_
#PROXY : _DEBIAN 10
# ==================================================
# Initializing Var

MYIP=$(wget -qO- ipv4.icanhazip.com);
MYIP2="s/xxxxxxxxx/$MYIP/g";

# Install Squid3
cd
apt-get -y install squid
wget -O /etc/squid/squid.conf "https://raw.githubusercontent.com/MyGatherBk/MyAuto/master/squid.conf"
sed -i $MYIP2 /etc/squid/squid.conf;
systemctl squid restart
