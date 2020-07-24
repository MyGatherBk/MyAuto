#!/bin/bash
# Modified by : _MyGatherBK_
#PROXY : _DEBIAN 10
# ==================================================
# Initializing Var

MYIP=$(wget -qO- ipv4.icanhazip.com);
MYIP2="s/xxxxxxxxx/$MYIP/g";

# Install Squid3
cd
apt-get -y install squid3
wget -O /etc/squid3/squid.conf "https://raw.githubusercontent.com/MyGatherBk/MyAuto/master/squid3.conf"
sed -i $MYIP2 /etc/squid3/squid.conf;
systemctl squid3 restart