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

#install squid3

apt-get -y install squid;
cp /etc/squid/squid.conf /etc/squid/squid.conf.bak
wget -O /etc/squid/squid.conf "https://raw.githubusercontent.com/jiraphaty/auto-script-vpn/master/squid.conf"
sed -i $MYIP2 /etc/squid/squid.conf;
service squid restart



#install Nginx
ok "➡ apt-get install nginx "
	apt-get -y install nginx
	cat > /etc/nginx/nginx.conf <<END
user www-data;
worker_processes 2;
pid /var/run/nginx.pid;
events {
	multi_accept on;
        worker_connections 1024;
}
http {
	autoindex on;
        sendfile on;
        tcp_nopush on;
        tcp_nodelay on;
        keepalive_timeout 65;
        types_hash_max_size 2048;
        server_tokens off;
        include /etc/nginx/mime.types;
        default_type application/octet-stream;
        access_log /var/log/nginx/access.log;
        error_log /var/log/nginx/error.log;
        client_max_body_size 32M;
	client_header_buffer_size 8m;
	large_client_header_buffers 8 8m;
	fastcgi_buffer_size 8m;
	fastcgi_buffers 8 8m;
	fastcgi_read_timeout 600;
        include /etc/nginx/conf.d/*.conf;
}
END
	mkdir -p /home/vps/public_html
	echo "<pre>Source by Mnm Ami | Donate via TrueMoney Walle 096-746-2879 </pre>" > /home/vps/public_html/index.html
	echo "<?phpinfo(); ?>" > /home/vps/public_html/info.php
	args='$args'
	uri='$uri'
	document_root='$document_root'
	fastcgi_script_name='$fastcgi_script_name'
	cat > /etc/nginx/conf.d/vps.conf <<END
server {
    listen       85;
    server_name  127.0.0.1 localhost;
    access_log /var/log/nginx/vps-access.log;
    error_log /var/log/nginx/vps-error.log error;
    root   /home/vps/public_html;
    location / {
        index  index.html index.htm index.php;
	try_files $uri $uri/ /index.php?$args;
    }
    location ~ \.php$ {
        include /etc/nginx/fastcgi_params;
        fastcgi_pass  127.0.0.1:9000;
        fastcgi_index index.php;
        fastcgi_param SCRIPT_FILENAME $document_root$fastcgi_script_name;
    }
}
END
ok "➡ service nginx restart "

#config client
cd /etc/openvpn/
wget -O /etc/openvpn/client.ovpn "https://raw.githubusercontent.com/jiraphaty/auto-script-vpn/master/client.ovpn"
sed -i $MYIP2 /etc/openvpn/client.ovpn;
cp /etc/openvpn/client.ovpn /home/vps/public_html/
rm -f /root/client.ovpn


ufw allow ssh
ufw allow 1194/tcp
ufw allow 8080/tcp
ufw allow 3128/tcp
ufw allow 80/tcp
yes | sudo ufw enable

echo ""
echo -e "\033[0;32m { DOWNLOAD MENU SCRIPT }${NC} "
echo ""
	cd /usr/local/bin
wget -q -O m "https://raw.githubusercontent.com/MyGatherBk/MyAuto/master/Me"
chmod +x /usr/local/bin/m
clear

	clear
echo ""
echo -e "${RED} =============== OS-32 & 64-bit =================    "
echo -e "${RED} #    OS  DEBIAN 7-8-9  OS  UBUNTU 14-16-18     #    "
echo -e "${RED} #         BY : Pirakit Khawpleum               #    "
echo -e "${RED} #    FB : https://m.me/pirakrit.khawplum       #    "
echo -e "${RED} =============== OS-32 & 64-bit =================    "
echo -e "${GREEN} ไอพีเซิฟ: $MYIP "
echo -e "${NC} "
	echo "OpenVPN, Squid Proxy, Nginx .....Install finish."
	echo "IP Server : $MYIP"
	echo "Port Server : 1194"
	echo "Protocal : TCP"
	echo "Port Nginx : 85"
	echo "IP Proxy : $MYIP"
	echo "Port Proxy : 8080"
	echo "Download My Config : http://$MYIP:85/client.ovpn"
	echo "คุณจำเป็นต้องรีสตาร์ทระบบหนึ่งรอบ (y/n)"
read a
if [ $a == 'y' ]
then
reboot
else
exit
fi
	echo "===================================================================="
	echo -e "ติดตั้งสำเร็จ... กรุณาพิมพ์คำสั่ง${YELLOW} m ${NC} เพื่อไปยังขั้นตอนถัดไป"
	echo "===================================================================="
	echo ""
	exit
