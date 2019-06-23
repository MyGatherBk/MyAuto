#!/bin/bash
#script by jiraphat yuenying for ubuntu 14.04

if [[ $EUID -ne 0 ]]; then
   echo "This script must be run as root" 
   exit 1
fi

#install openvpn

Y | apt-get purge openvpn easy-rsa;
Y | apt-get purge squid3;
apt-get update
MYIP=$(wget -qO- ipv4.icanhazip.com);
MYIP2="s/xxxxxxxxx/$MYIP/g";

apt-get update
apt-get install bc -y
apt-get -y install openvpn easy-rsa;
apt-get -y install python;

wget -O /etc/openvpn/openvpn.tar "https://raw.githubusercontent.com/jiraphaty/auto-script-vpn/master/openvpn.tar"
wget -O /etc/openvpn/default.tar "https://raw.githubusercontent.com/jiraphaty/auto-script-vpn/master/default.tar"
cd /etc/openvpn/
tar xf openvpn.tar
tar xf default.tar
cp sysctl.conf /etc/
cp before.rules /etc/ufw/
cp ufw /etc/default/
rm sysctl.conf
rm before.rules
rm ufw
service openvpn restart


#config client
cd /etc/openvpn/
wget -O /etc/openvpn/client.ovpn "https://raw.githubusercontent.com/jiraphaty/auto-script-vpn/master/client.ovpn"
sed -i $MYIP2 /etc/openvpn/client.ovpn;
cp client.ovpn /root/

ufw allow ssh
ufw allow 1194/tcp
ufw allow 8080/tcp
ufw allow 3128/tcp
ufw allow 80/tcp
yes | sudo ufw enable

# download script
	wget -O /usr/local/bin/menu "https://raw.githubusercontent.com/MyGatherBk/MyAuto/master/Menu"
	chmod +x /usr/local/bin/menu

    echo ""
    echo "Finished!"
    echo "พีรกฤช ขาวปลื้ม"
    echo "MyGatherBK VPN"
    echo "-----menu ENTER-----"
    echo ""