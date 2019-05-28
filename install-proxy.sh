#!/bin/bash

fi

if [[ "$EUID" -ne 0 ]]; then
	echo "Sorry, you need to run this as root"
	exit
fi

if [[ ! -e /dev/net/tun ]]; then
	echo "The TUN device is not available
You need to enable TUN before running this script"
	exit
fi

if [[ -e /etc/debian_version ]]; then
	OS=debian
	GROUPNAME=nogroup
	RCLOCAL='/etc/rc.local'
elif [[ -e /etc/centos-release || -e /etc/redhat-release ]]; then
	OS=centos
	GROUPNAME=nobody
	RCLOCAL='/etc/rc.d/rc.local'
else
	echo "Looks like you aren't running this installer on Debian, Ubuntu or CentOS"
	exit
fi


# Menu
	echo ""
	echo "~¤~ ๏[-ิ_•ิ]๏ ~¤~ Admin MyGatherBK ~¤~ ๏[-ิ_•ิ]๏ ~¤~"
	echo ""
		if [[ "$VERSION_ID" = 'VERSION_ID="7"' || "$VERSION_ID" = 'VERSION_ID="8"' || "$VERSION_ID" = 'VERSION_ID="14.04"' ]]; then
		if [[ ! -e /etc/squid3/squid.conf ]]; then
			echo -e "|1| ติดตั้ง SQUID PROXY"
		elif [[ -e /etc/squid3/squid.conf ]]; then
			echo -e "|1| ถอนการติดตั้ง SQUID PROXY"
		fi

	elif [[ "$VERSION_ID" = 'VERSION_ID="9"' || "$VERSION_ID" = 'VERSION_ID="16.04"' || "$VERSION_ID" = 'VERSION_ID="17.04"' ]]; then
		if [[ ! -e /etc/squid/squid.conf ]]; then
			echo -e "|1}| ติดตั้ง SQUID PROXY"
		elif [[ -e /etc/squid/squid.conf ]]; then
			echo -e "|1| ถอนการติดตั้ง SQUID PROXY"
		fi


	1) # ==================================================================================================================

if [[ -e /etc/squid3/squid.conf ]]; then
	apt-get -y remove --purge squid3
	clear
	echo ""
	echo "~¤~ ๏[-ิ_•ิ]๏ ~¤~ Admin MyGatherBK ~¤~ ๏[-ิ_•ิ]๏ ~¤~"
	echo ""
	echo "Squid Proxy .....Removed."
	exit
elif [[ -e /etc/squid/squid.conf ]]; then
	apt-get -y remove --purge squid
	clear
	echo ""
	echo "~¤~ ๏[-ิ_•ิ]๏ ~¤~ Admin MyGatherBK ~¤~ ๏[-ิ_•ิ]๏ ~¤~"
	echo ""
	echo "Squid Proxy .....Removed."
	exit
fi

read -p "Port Proxy : " -e -i 8080 PROXY

if [[ "$VERSION_ID" = 'VERSION_ID="7"' || "$VERSION_ID" = 'VERSION_ID="8"' || "$VERSION_ID" = 'VERSION_ID="14.04"' ]]; then
	apt-get -y install squid3
	cat > /etc/squid3/squid.conf <<END
http_port $PROXY
acl localhost src 127.0.0.1/32 ::1
acl to_localhost dst 127.0.0.0/8 0.0.0.0/32 ::1
acl localnet src 10.0.0.0/8
acl localnet src 172.16.0.0/12
acl localnet src 192.168.0.0/16
acl SSL_ports port 443
acl Safe_ports port 80
acl Safe_ports port 21
acl Safe_ports port 443
acl Safe_ports port 70
acl Safe_ports port 210
acl Safe_ports port 1025-65535
acl Safe_ports port 280
acl Safe_ports port 488
acl Safe_ports port 591
acl Safe_ports port 777
acl CONNECT method CONNECT
acl SSH dst xxxxxxxxx-xxxxxxxxx/255.255.255.255
http_access allow SSH
http_access allow localnet
http_access allow localhost
http_access deny all
refresh_pattern ^ftp:           1440    20%     10080
refresh_pattern ^gopher:        1440    0%      1440
refresh_pattern -i (/cgi-bin/|\?) 0     0%      0
refresh_pattern .               0       20%     4320
END
	IP2="s/xxxxxxxxx/$IP/g";
	sed -i $IP2 /etc/squid3/squid.conf;
	if [[ "$VERSION_ID" = 'VERSION_ID="14.04"' ]]; then
		service squid3 restart
	else
		/etc/init.d/squid3 restart
	fi
	clear
	echo ""
	echo "~¤~ ๏[-ิ_•ิ]๏ ~¤~ Admin MyGatherBK ~¤~ ๏[-ิ_•ิ]๏ ~¤~"
	echo ""
	echo "Squid Proxy .....Install finish."
	echo "IP Proxy : $IP"
	echo "Port Proxy : $PROXY"
	echo ""
	exit

elif [[ "$VERSION_ID" = 'VERSION_ID="9"' || "$VERSION_ID" = 'VERSION_ID="16.04"' || "$VERSION_ID" = 'VERSION_ID="17.04"' ]]; then
	apt-get -y install squid
	cat > /etc/squid/squid.conf <<END
http_port $PROXY
acl localhost src 127.0.0.1/32 ::1
acl to_localhost dst 127.0.0.0/8 0.0.0.0/32 ::1
acl localnet src 10.0.0.0/8
acl localnet src 172.16.0.0/12
acl localnet src 192.168.0.0/16
acl SSL_ports port 443
acl Safe_ports port 80
acl Safe_ports port 21
acl Safe_ports port 443
acl Safe_ports port 70
acl Safe_ports port 210
acl Safe_ports port 1025-65535
acl Safe_ports port 280
acl Safe_ports port 488
acl Safe_ports port 591
acl Safe_ports port 777
acl CONNECT method CONNECT
acl SSH dst xxxxxxxxx-xxxxxxxxx/255.255.255.255
http_access allow SSH
http_access allow localnet
http_access allow localhost
http_access deny all
refresh_pattern ^ftp:           1440    20%     10080
refresh_pattern ^gopher:        1440    0%      1440
refresh_pattern -i (/cgi-bin/|\?) 0     0%      0
refresh_pattern .               0       20%     4320
END
	IP2="s/xxxxxxxxx/$IP/g";
	sed -i $IP2 /etc/squid/squid.conf;
	/etc/init.d/squid restart
	clear
	echo ""
	echo "~¤~ ๏[-ิ_•ิ]๏ ~¤~ Admin MyGatherBK ~¤~ ๏[-ิ_•ิ]๏ ~¤~"
	echo ""
	echo "Squid Proxy .....Install finish."
	echo "IP Proxy : $IP"
	echo "Port Proxy : $PROXY"
	echo ""
	exit

fi

	;;
