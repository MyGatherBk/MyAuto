#/bin/bash
cat -n /etc/issue |grep 1 |cut -d' ' -f6,7,8 |sed 's/1//' |sed 's/	//' > /etc/so 
echo -e "\033[1;33m- - - - -> \033[01;34mทำงานบนระบบ:\033[0m $(cat /etc/so)"
os=$(cat /etc/so)
echo -e "กรุณาใส่ ip ของคุณ" ; read ip
clear
echo -e "\033[1;33m- - - - -> \033[01;34mสร้างเเละจัดทำโดย @"$squidfail"\033[01;33m $squidcre\033[0m"
echo -e "\033[1;33m- - - - -> \033[01;34mทำงานบนระบบ:\033[0m $(cat /etc/so)"
echo -e "\033[1;33m- - - - -> \033[01;34mIP ของคุณ:\033[0m $ip"
echo -e "\033[1;32mพร็อกซี่เเละพอต :\033[0m $ip \033[0m 80, 8080, 8799, 3128"
echo -e "\033[1;32m       -- 
Terms of Use --"
echo -e "\033[1;32m# ห้ามนำไปใช้ในทางที่ไม่ถูกต้อง."
echo -e "\033[1;32m# ห้ามนำไปขายต่อ"
echo -e "\033[1;32m# สร้างเเละจำทำโดย Otaku Mystery !!\033[0m" 
echo -e "\033[1;32m# หากมีข้อผิดพลาดประการใดก็ขออภัยไว้ ณ ที่นี้
# ขอบคุณที่เลือกเรา\033[0m เริ่มตั้งค่า"

echo '#!/bin/bash
echo "Youtube 
http://youtube.com/c/otakumystery"' > /bin/canalconf
chmod a+x /bin/canalconf

if cat /etc/so |grep -i ubuntu |grep 16 1> /dev/null 2> /dev/null ; then
echo -e "\033[01;31mกำลังติดตั้ง...\033[0m"
apt-get update 1> /dev/null 2> /dev/null
apt-get install squid -y 1> /dev/null 2> /dev/null
apt-get install squid3 -y 1> /dev/null 2> /dev/null
apt-get install ufw -y 1> /dev/null 2> /dev/null

service apache2 stop 1> /dev/null 2> /dev/null

# set locale
wget -O /etc/ssh/sshd_config 'https://raw.githubusercontent.com/MyGatherBk/MyAuto/master/sshd_config'
service ssh restart


service ssh restart 1> /dev/null 2> /dev/null

cd /etc/squid
echo "http_port 80" >> squid.conf
echo "http_port 8080" >> squid.conf
echo "http_port 3128" >> squid.conf
echo "http_port 3306" >> squid.conf
echo "visible_hostname otakumysterych.cf" >> squid.conf
echo "acl ip dstdomain $ip" >> squid.conf
echo "acl accept method GET" >> squid.conf
echo "acl accept method POST" >> squid.conf
echo "acl accept method OPTIONS" >> squid.conf
echo "acl accept method CONNECT" >> squid.conf
echo "acl accept method PUT" >> squid.conf
echo "acl HEAD method HEAD" >> squid.conf
echo "http_access allow ip" >> squid.conf
echo "http_access allow accept" >> squid.conf
echo "http_access allow HEAD" >> squid.conf
echo "http_access allow all" >> squid.conf

service squid restart 1> /dev/null 2> /dev/null

ufw allow 443 1>/dev/null 2>/dev/null
ufw allow 80 1>/dev/null 2>/dev/null
ufw allow 8080 1>/dev/null 2>/dev/null
ufw allow 3128 1>/dev/null 2>/dev/null
ufw allow 3306 1>/dev/null 2>/dev/null

cd /etc/squid3
echo "http_port 80" >> squid.conf
echo "http_port 8080" >> squid.conf
echo "http_port 3128" >> squid.conf
echo "http_port 3306" >> squid.conf
echo "visible_hostname otakumysterych.cf" >> squid.conf
echo "acl ip dstdomain $ip" >> squid.conf
echo "acl accept method GET" >> squid.conf
echo "acl accept method POST" >> squid.conf
echo "acl accept method OPTIONS" >> squid.conf
echo "acl accept method CONNECT" >> squid.conf
echo "acl accept method PUT" >> squid.conf
echo "acl HEAD method HEAD" >> squid.conf
echo "http_access allow ip" >> squid.conf
echo "http_access allow accept" >> squid.conf
echo "http_access allow HEAD" >> squid.conf
echo "http_access allow all" >> squid.conf

service squid3 restart 1> /dev/null 2> /dev/null

ufw allow 443 1>/dev/null 2>/dev/null
ufw allow 80 1>/dev/null 2>/dev/null
ufw allow 8080 1>/dev/null 2>/dev/null
ufw allow 3128 1>/dev/null 2>/dev/null
ufw allow 3306 1>/dev/null 2>/dev/null

echo "=======================================" 
echo "            MygatherBK" 
echo "======================================="
exit 0
fi

if cat /etc/so |grep -i ubuntu 1> /dev/null 2> /dev/null ; then
echo -e "\033[01;31mกำลังติดตั้ง...\033[0m"
apt-get update 1> /dev/null 2> /dev/null
apt-get install squid -y 1> /dev/null 2> /dev/null
apt-get install squid3 -y 1> /dev/null 2> /dev/null
apt-get install ufw -y 1> /dev/null 2> /dev/null

service apache2 stop 1> /dev/null 2> /dev/null


# set locale
wget -O /etc/ssh/sshd_config 'https://raw.githubusercontent.com/MyGatherBk/MyAuto/master/sshd_config'
service ssh restart


service ssh restart 1> /dev/null 2> /dev/null

cd /etc/squid
echo "http_port 80" >> squid.conf
echo "http_port 8080" >> squid.conf
echo "http_port 3128" >> squid.conf
echo "http_port 3306" >> squid.conf
echo "visible_hostname otakumysterych.cf" >> squid.conf
echo "acl ip dstdomain $ip" >> squid.conf
echo "acl accept method GET" >> squid.conf
echo "acl accept method POST" >> squid.conf
echo "acl accept method OPTIONS" >> squid.conf
echo "acl accept method CONNECT" >> squid.conf
echo "acl accept method PUT" >> squid.conf
echo "acl HEAD method HEAD" >> squid.conf
echo "http_access allow ip" >> squid.conf
echo "http_access allow accept" >> squid.conf
echo "http_access allow HEAD" >> squid.conf
echo "http_access allow all" >> squid.conf

service squid restart 1> /dev/null 2> /dev/null

ufw allow 443 1>/dev/null 2>/dev/null
ufw allow 80 1>/dev/null 2>/dev/null
ufw allow 8080 1>/dev/null 2>/dev/null
ufw allow 3128 1>/dev/null 2>/dev/null
ufw allow 3306 1>/dev/null 2>/dev/null

cd /etc/squid3
echo "http_port 80" >> squid.conf
echo "http_port 8080" >> squid.conf
echo "http_port 3128" >> squid.conf
echo "http_port 3306" >> squid.conf
echo "visible_hostname otakumysterych.cf" >> squid.conf
echo "acl ip dstdomain $ip" >> squid.conf
echo "acl accept method GET" >> squid.conf
echo "acl accept method POST" >> squid.conf
echo "acl accept method OPTIONS" >> squid.conf
echo "acl accept method CONNECT" >> squid.conf
echo "acl accept method PUT" >> squid.conf
echo "acl HEAD method HEAD" >> squid.conf
echo "http_access allow ip" >> squid.conf
echo "http_access allow accept" >> squid.conf
echo "http_access allow HEAD" >> squid.conf
echo "http_access allow all" >> squid.conf

service squid3 restart 1> /dev/null 2> /dev/null

ufw allow 443 1>/dev/null 2>/dev/null
ufw allow 80 1>/dev/null 2>/dev/null
ufw allow 8080 1>/dev/null 2>/dev/null
ufw allow 3128 1>/dev/null 2>/dev/null
ufw allow 3306 1>/dev/null 2>/dev/null

echo "=======================================" 
echo "            MygatherBK" 
echo "======================================="
exit 0
fi

if cat /etc/so |grep -i centos 1> /dev/null 2> /dev/null ; then
echo -e "\033[01;31mกำลังติดตั้ง...\033[0m"
yum update 1> /dev/null 2> /dev/null
yum install squid -y 1> /dev/null 2> /dev/null
yum install squid3 -y 1> /dev/null 2> /dev/null
yum install ufw -y 1> /dev/null 2> /dev/null

service apache2 stop 1> /dev/null 2> /dev/null

# set locale
wget -O /etc/ssh/sshd_config 'https://raw.githubusercontent.com/MyGatherBk/MyAuto/master/sshd_config'
service ssh restart


service sshd restart 1> /dev/null 2> /dev/null

cd /etc/squid
echo "http_port 80" >> squid.conf
echo "http_port 8080" >> squid.conf
echo "http_port 3128" >> squid.conf
echo "http_port 3306" >> squid.conf
echo "visible_hostname otakumysterych.cf" >> squid.conf
echo "acl ip dstdomain $ip" >> squid.conf
echo "acl accept method GET" >> squid.conf
echo "acl accept method POST" >> squid.conf
echo "acl accept method OPTIONS" >> squid.conf
echo "acl accept method CONNECT" >> squid.conf
echo "acl accept method PUT" >> squid.conf
echo "acl HEAD method HEAD" >> squid.conf
echo "http_access allow ip" >> squid.conf
echo "http_access allow accept" >> squid.conf
echo "http_access allow HEAD" >> squid.conf
echo "http_access allow all" >> squid.conf

service squid restart 1> /dev/null 2> /dev/null

ufw allow 443 1>/dev/null 2>/dev/null
ufw allow 80 1>/dev/null 2>/dev/null
ufw allow 8080 1>/dev/null 2>/dev/null
ufw allow 3128 1>/dev/null 2>/dev/null
ufw allow 3306 1>/dev/null 2>/dev/null

cd /etc/squid3
echo "http_port 80" >> squid.conf
echo "http_port 8080" >> squid.conf
echo "http_port 3128" >> squid.conf
echo "http_port 3306" >> squid.conf
echo "visible_hostname otakumysterych.cf" >> squid.conf
echo "acl ip dstdomain $ip" >> squid.conf
echo "acl accept method GET" >> squid.conf
echo "acl accept method POST" >> squid.conf
echo "acl accept method OPTIONS" >> squid.conf
echo "acl accept method CONNECT" >> squid.conf
echo "acl accept method PUT" >> squid.conf
echo "acl HEAD method HEAD" >> squid.conf
echo "http_access allow ip" >> squid.conf
echo "http_access allow accept" >> squid.conf
echo "http_access allow HEAD" >> squid.conf
echo "http_access allow all" >> squid.conf

service squid3 restart 1> /dev/null 2> /dev/null

ufw allow 443 1>/dev/null 2>/dev/null
ufw allow 80 1>/dev/null 2>/dev/null
ufw allow 8080 1>/dev/null 2>/dev/null
ufw allow 3128 1>/dev/null 2>/dev/null
ufw allow 3306 1>/dev/null 2>/dev/null

echo "=======================================" 
echo "            MygatherBK" 
echo "======================================="
exit 0
fi
if cat /etc/so |grep -i debian 1> /dev/null 2> /dev/null ; then
echo -e "\033[01;31mกำลังติดตั้ง...\033[0m"
apt-get update 1> /dev/null 2> /dev/null
apt-get install squid -y 1> /dev/null 2> /dev/null
apt-get install squid3 -y 1> /dev/null 2> /dev/null
apt-get install ufw -y 1> /dev/null 2> /dev/null

service apache2 stop 1> /dev/null 2> /dev/null

# set locale
wget -O /etc/ssh/sshd_config 'https://raw.githubusercontent.com/MyGatherBk/MyAuto/master/sshd_config'
service ssh restart


cd /etc/squid
echo "http_port 80" >> squid.conf
echo "http_port 8080" >> squid.conf
echo "http_port 3128" >> squid.conf
echo "http_port 3306" >> squid.conf
echo "visible_hostname otakumysterych.cf" >> squid.conf
echo "acl ip dstdomain $ip" >> squid.conf
echo "acl accept method GET" >> squid.conf
echo "acl accept method POST" >> squid.conf
echo "acl accept method OPTIONS" >> squid.conf
echo "acl accept method CONNECT" >> squid.conf
echo "acl accept method PUT" >> squid.conf
echo "acl HEAD method HEAD" >> squid.conf
echo "http_access allow ip" >> squid.conf
echo "http_access allow accept" >> squid.conf
echo "http_access allow HEAD" >> squid.conf
echo "http_access allow all" >> squid.conf

service squid restart 1> /dev/null 2> /dev/null

ufw allow 443 1>/dev/null 2>/dev/null
ufw allow 80 1>/dev/null 2>/dev/null
ufw allow 8080 1>/dev/null 2>/dev/null
ufw allow 3128 1>/dev/null 2>/dev/null
ufw allow 3306 1>/dev/null 2>/dev/null

cd /etc/squid3
echo "http_port 80" >> squid.conf
echo "http_port 8080" >> squid.conf
echo "http_port 3128" >> squid.conf
echo "http_port 3306" >> squid.conf
echo "visible_hostname otakumysterych.cf" >> squid.conf
echo "acl ip dstdomain $ip" >> squid.conf
echo "acl accept method GET" >> squid.conf
echo "acl accept method POST" >> squid.conf
echo "acl accept method OPTIONS" >> squid.conf
echo "acl accept method CONNECT" >> squid.conf
echo "acl accept method PUT" >> squid.conf
echo "acl HEAD method HEAD" >> squid.conf
echo "http_access allow ip" >> squid.conf
echo "http_access allow accept" >> squid.conf
echo "http_access allow HEAD" >> squid.conf
echo "http_access allow all" >> squid.conf

service squid3 restart 1> /dev/null 2> /dev/null

ufw allow 443 1>/dev/null 2>/dev/null
ufw allow 80 1>/dev/null 2>/dev/null
ufw allow 8080 1>/dev/null 2>/dev/null
ufw allow 3128 1>/dev/null 2>/dev/null
ufw allow 3306 1>/dev/null 2>/dev/null

echo "=======================================" 
echo "            MygatherBK" 
echo "======================================="
exit 0
fi
