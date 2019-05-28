#!/bin/bash

apt-get -y install squid3
wget -O /etc/squid3/squid.conf "https://raw.githubusercontent.com/MyGatherBk/MyAuto/master/squid.conf"
sed -i $MYIP2 /etc/squid3/squid.conf;
service squid3 restart

# install squid
apt-get -y install squid
wget -O /etc/squid/squid.conf "https://raw.githubusercontent.com/MyGatherBk/MyAuto/master/squid.conff"
sed -i $MYIP2 /etc/squid/squid.conf;
service squid restart
