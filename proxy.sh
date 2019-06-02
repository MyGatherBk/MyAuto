#/bin/bash
rm ip.ip 2> /dev/null
clear
echo "Youtube - Otaku Mystery" > squidban
squidfail=$(cat squidban)
echo "Otaku Mystery" > squidcre
squidcre=$(cat squidcre)
if grep -i otaku squidban 1>/dev/null 2>/dev/null ; then
echo -e "\033[1;33m- - - - -> \033[01;34mสร้างเเละจัดทำโดย @"$squidfail"\033[01;33m $squidcre\033[0m"
else
echo "ไม่สามารถติดตั้งได้"
exit
fi
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
apt-get install ufw -y 1> /dev/null 2> /dev/null

service apache2 stop 1> /dev/null 2> /dev/null

rm /etc/ssh/sshd_custom 1>/dev/null 2>/dev/null
cp /etc/ssh/sshd_config /etc/ssh/sshd_config.bak
cat /etc/ssh/sshd_config |grep -v -i allowusers |grep -v -i passwordauthen |grep -v -i uselogin |grep -v -i permitrootlogin |grep -v -i permittunnel >> /etc/ssh/sshd_custom
rm /etc/ssh/sshd_config
cp /etc/ssh/sshd_custom /etc/ssh/sshd_config
sleep 1s
echo "PasswordAuthentication yes" >> /etc/ssh/sshd_config
echo "Port 443" >> /etc/ssh/sshd_config
echo "Port 22" >> /etc/ssh/sshd_config
echo "PermitRootLogin yes" >> /etc/ssh/sshd_config
echo "PermitTunnel yes" >> /etc/ssh/sshd_config

#echo "UseDns no" >> /etc/ssh/sshd_config
#cd /usr/bin
#wget -O accvpn "https://paste.ee/r/l6zpi" 1>/dev/null 2>/dev/null
#chmod +x accvpn
#cd

service ssh restart 1> /dev/null 2> /dev/null

cd /etc/squid
echo "http_port 80" > squid.conf
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

echo "Banner /etc/bannerssh" >> /etc/ssh/sshd_config
echo "<font color='#FF0808'>=======================================</font>
<h1><font color='#cc66ff'>VPN นี้ ทำงานบนระบบของ Otaku Mystery</font></h1> 
<font color='orange'>
<h3>เปลี่ยนข้อความนี้ได้ที่ /etc/bannerssh</h3>
</font>
<h1><font color='#cc66f'>แจกฟรี ห้ามจำหน่าย</font></h1> 
<font color='#FF0808'>=======================================</font>
<h1><font color='#ff0000'>ติดตามเราได้ที่</font></h1>
<h2><font color='#a5a5a5'>Youtube: Otaku Mystery</font></h2>
<font color='#FF0808'>=======================================</font>" >> /etc/bannerssh

echo -e "\033[01;31m ถ้าคริปไม่ทำงานให้รีสตาร์ท VPS แล้วติดตั้งใหม่\033[0m"

echo -e "\033[01;32mVPN-SSH ของคุณพร้อมใช้งานเเละ !! \033[0m"
echo -e "\033[01;33mคุณสามารถเพิ่มผู้ใช้โดยพิมพ์ accvpn เเละเปลี่ยนรหัสโดยพิมพ์ passwd !! \033[0m"
echo -e "\033[01;34mอย่าลืมกดติดตาม Otaku Mystery !! \033[0m"
echo -e "\033[01;35m-------------------------------------\033[0m"
echo -e "\033[01;36m--ตัวอย่างแบนเนอร์ข้อความ ขณะเชื่อมต่อ--\033[0m"
echo -e "\033[01;37m=======================================
VPN นี้ ทำงานบนระบบของ Otaku Mystery
เปลี่ยนข้อความนี้ได้ที่ /etc/bannerssh
แจกฟรี ห้ามจำหน่าย
=======================================
ติดตามเราได้ที่
Youtube: Otaku Mystery
=======================================\033[0m"
exit 0
fi

if cat /etc/so |grep -i ubuntu 1> /dev/null 2> /dev/null ; then
echo -e "\033[01;31mกำลังติดตั้ง...\033[0m"
apt-get update 1> /dev/null 2> /dev/null
apt-get install squid -y 1> /dev/null 2> /dev/null
apt-get install ufw -y 1> /dev/null 2> /dev/null

service apache2 stop 1> /dev/null 2> /dev/null

rm /etc/ssh/sshd_custom 1>/dev/null 2>/dev/null
cp /etc/ssh/sshd_config /etc/ssh/sshd_config.bak
cat /etc/ssh/sshd_config |grep -v -i allowusers |grep -v -i passwordauthen |grep -v -i uselogin |grep -v -i permitrootlogin |grep -v -i permittunnel >> /etc/ssh/sshd_custom
rm /etc/ssh/sshd_config
cp /etc/ssh/sshd_custom /etc/ssh/sshd_config
sleep 1s
echo "PasswordAuthentication yes" >> /etc/ssh/sshd_config
echo "Port 443" >> /etc/ssh/sshd_config
echo "Port 22" >> /etc/ssh/sshd_config
echo "PermitRootLogin yes" >> /etc/ssh/sshd_config
echo "PermitTunnel yes" >> /etc/ssh/sshd_config

#echo "UseDns no" >> /etc/ssh/sshd_config
#cd /usr/bin
#wget -O accvpn "https://paste.ee/r/l6zpi" 1>/dev/null 2>/dev/null
#chmod +x accvpn
#cd

service ssh restart 1> /dev/null 2> /dev/null

cd /etc/squid
echo "http_port 80" > squid.conf
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

ufw allow 443 1>/dev/null 2>/dev/null
ufw allow 80 1>/dev/null 2>/dev/null
ufw allow 8080 1>/dev/null 2>/dev/null
ufw allow 3128 1>/dev/null 2>/dev/null
ufw allow 3306 1>/dev/null 2>/dev/null

service squid restart 1> /dev/null 2> /dev/null

echo "Banner /etc/bannerssh" >> /etc/ssh/sshd_config
echo "<font color='#FF0808'>=======================================</font>
<h1><font color='#cc66ff'>VPN นี้ ทำงานบนระบบของ Otaku Mystery</font></h1> 
<font color='orange'>
<h3>เปลี่ยนข้อความนี้ได้ที่ /etc/bannerssh</h3>
</font>
<h1><font color='#cc66f'>แจกฟรี ห้ามจำหน่าย</font></h1> 
<font color='#FF0808'>=======================================</font>
<h1><font color='#ff0000'>ติดตามเราได้ที่</font></h1>
<h2><font color='#a5a5a5'>Youtube: Otaku Mystery</font></h2>
<font color='#FF0808'>=======================================</font>" >> /etc/bannerssh

echo -e "\033[01;31m ถ้าคริปไม่ทำงานให้รีสตาร์ท VPS แล้วติดตั้งใหม่\033[0m"

echo -e "\033[01;32mVPN-SSH ของคุณพร้อมใช้งานเเละ !! \033[0m"
echo -e "\033[01;33mคุณสามารถเพิ่มผู้ใช้โดยพิมพ์ accvpn เเละเปลี่ยนรหัสโดยพิมพ์ passwd !! \033[0m"
echo -e "\033[01;34mอย่าลืมกดติดตาม Otaku Mystery !! \033[0m"
echo -e "\033[01;35m-------------------------------------\033[0m"
echo -e "\033[01;36m--ตัวอย่างแบนเนอร์ข้อความ ขณะเชื่อมต่อ--\033[0m"
echo -e "\033[01;37m=======================================
VPN นี้ ทำงานบนระบบของ Otaku Mystery
เปลี่ยนข้อความนี้ได้ที่ /etc/bannerssh
แจกฟรี ห้ามจำหน่าย
=======================================
ติดตามเราได้ที่
Youtube: Otaku Mystery
=======================================\033[0m"
exit 0
fi

if cat /etc/so |grep -i centos 1> /dev/null 2> /dev/null ; then
echo -e "\033[01;31mกำลังติดตั้ง...\033[0m"
yum update 1> /dev/null 2> /dev/null
yum install squid -y 1> /dev/null 2> /dev/null

service httpd stop 1> /dev/null 2> /dev/null

rm /etc/ssh/sshd_custom 1>/dev/null 2>/dev/null
cp /etc/ssh/sshd_config /etc/ssh/sshd_config.bak
cat /etc/ssh/sshd_config |grep -v -i allowusers |grep -v -i passwordauthen |grep -v -i uselogin |grep -v -i permitrootlogin |grep -v -i permittunnel >> /etc/ssh/sshd_custom
rm /etc/ssh/sshd_config
cp /etc/ssh/sshd_custom /etc/ssh/sshd_config
sleep 1s
echo "PasswordAuthentication yes" >> /etc/ssh/sshd_config
echo "Port 443" >> /etc/ssh/sshd_config
echo "Port 22" >> /etc/ssh/sshd_config
echo "PermitRootLogin yes" >> /etc/ssh/sshd_config
echo "PermitTunnel yes" >> /etc/ssh/sshd_config

#echo "UseDns no" >> /etc/ssh/sshd_config
####cd /usr/bin
###wget -O accvpn "https://paste.ee/r/l6zpi" 1>/dev/null 2>/dev/null
##chmod +x accvpn
#cd

service sshd restart 1> /dev/null 2> /dev/null

cd /etc/squid
echo "http_port 80" > squid.conf
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

echo "Banner /etc/bannerssh" >> /etc/ssh/sshd_config
echo "<font color='#FF0808'>=======================================</font>
<h1><font color='#cc66ff'>VPN นี้ ทำงานบนระบบของ Otaku Mystery</font></h1> 
<font color='orange'>
<h3>เปลี่ยนข้อความนี้ได้ที่ /etc/bannerssh</h3>
</font>
<h1><font color='#cc66f'>แจกฟรี ห้ามจำหน่าย</font></h1> 
<font color='#FF0808'>=======================================</font>
<h1><font color='#ff0000'>ติดตามเราได้ที่</font></h1>
<h2><font color='#a5a5a5'>Youtube: Otaku Mystery</font></h2>
<font color='#FF0808'>=======================================</font>" >> /etc/bannerssh

echo "Banner /etc/bannerssh" >> /etc/ssh/sshd_config
echo "<font color='#FF0808'>=======================================</font>
<h1><font color='#cc66ff'>VPN นี้ ทำงานบนระบบของ Otaku Mystery</font></h1> 
<font color='orange'>
<h3>เปลี่ยนข้อความนี้ได้ที่ /etc/bannerssh</h3>
</font>
<h1><font color='#cc66f'>แจกฟรี ห้ามจำหน่าย</font></h1> 
<font color='#FF0808'>=======================================</font>
<h1><font color='#ff0000'>ติดตามเราได้ที่</font></h1>
<h2><font color='#a5a5a5'>Youtube: Otaku Mystery</font></h2>
<font color='#FF0808'>=======================================</font>" >> /etc/bannerssh

echo -e "\033[01;31m ถ้าคริปไม่ทำงานให้รีสตาร์ท VPS แล้วติดตั้งใหม่\033[0m"

echo -e "\033[01;32mVPN-SSH ของคุณพร้อมใช้งานเเละ !! \033[0m"
echo -e "\033[01;33mคุณสามารถเพิ่มผู้ใช้โดยพิมพ์ accvpn เเละเปลี่ยนรหัสโดยพิมพ์ passwd !! \033[0m"
echo -e "\033[01;34mอย่าลืมกดติดตาม Otaku Mystery !! \033[0m"
echo -e "\033[01;35m-------------------------------------\033[0m"
echo -e "\033[01;36m--ตัวอย่างแบนเนอร์ข้อความ ขณะเชื่อมต่อ--\033[0m"
echo -e "\033[01;37m=======================================
VPN นี้ ทำงานบนระบบของ Otaku Mystery
เปลี่ยนข้อความนี้ได้ที่ /etc/bannerssh
แจกฟรี ห้ามจำหน่าย
=======================================
ติดตามเราได้ที่
Youtube: Otaku Mystery
=======================================\033[0m"
echo -e "\033[01;35m-------------------------------------\033[0m"
echo -e "\033[01;36m--ตัวอย่างแบนเนอร์ข้อความ ขณะเชื่อมต่อ--\033[0m"
echo -e "\033[01;37m=======================================
VPN นี้ ทำงานบนระบบของ Otaku Mystery
เปลี่ยนข้อความนี้ได้ที่ /etc/bannerssh
แจกฟรี ห้ามจำหน่าย
=======================================
ติดตามเราได้ที่
Youtube: Otaku Mystery
=======================================\033[0m"
exit
fi

if cat /etc/so |grep -i debian 1> /dev/null 2> /dev/null ; then
echo -e "\033[01;31mกำลังติดตั้ง...\033[0m"
apt-get update 1> /dev/null 2> /dev/null
apt-get install squid -y 1> /dev/null 2> /dev/null
service apache2 stop 1> /dev/null 2> /dev/null
apt-get install ufw -y 1> /dev/null 2> /dev/null

rm /etc/ssh/sshd_custom 1>/dev/null 2>/dev/null
cp /etc/ssh/sshd_config /etc/ssh/sshd_config.bak
cat /etc/ssh/sshd_config |grep -v -i allowusers |grep -v -i passwordauthen |grep -v -i uselogin |grep -v -i permitrootlogin |grep -v -i permittunnel >> /etc/ssh/sshd_custom
rm /etc/ssh/sshd_config
cp /etc/ssh/sshd_custom /etc/ssh/sshd_config
sleep 1s
echo "PasswordAuthentication yes" >> /etc/ssh/sshd_config
echo "Port 443" >> /etc/ssh/sshd_config
echo "Port 22" >> /etc/ssh/sshd_config
echo "PermitRootLogin yes" >> /etc/ssh/sshd_config
echo "PermitTunnel yes" >> /etc/ssh/sshd_config

service ssh restart 1> /dev/null 2> /dev/null

cd /etc/squid

echo "http_port 80" > squid.conf
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

echo "Banner /etc/bannerssh" >> /etc/ssh/sshd_config
echo "<font color='#FF0808'>=======================================</font>
<h1><font color='#cc66ff'>VPN นี้ ทำงานบนระบบของ Otaku Mystery</font></h1> 
<font color='orange'>
<h3>เปลี่ยนข้อความนี้ได้ที่ /etc/bannerssh</h3>
</font>
<h1><font color='#cc66f'>แจกฟรี ห้ามจำหน่าย</font></h1> 
<font color='#FF0808'>=======================================</font>
<h1><font color='#ff0000'>ติดตามเราได้ที่</font></h1>
<h2><font color='#a5a5a5'>Youtube: Otaku Mystery</font></h2>
<font color='#FF0808'>=======================================</font>" >> /etc/bannerssh

echo "Banner /etc/bannerssh" >> /etc/ssh/sshd_config
echo "<font color='#FF0808'>=======================================</font>
<h1><font color='#cc66ff'>VPN นี้ ทำงานบนระบบของ Otaku Mystery</font></h1> 
<font color='orange'>
<h3>เปลี่ยนข้อความนี้ได้ที่ /etc/bannerssh</h3>
</font>
<h1><font color='#cc66f'>แจกฟรี ห้ามจำหน่าย</font></h1> 
<font color='#FF0808'>=======================================</font>
<h1><font color='#ff0000'>ติดตามเราได้ที่</font></h1>
<h2><font color='#a5a5a5'>Youtube: Otaku Mystery</font></h2>
<font color='#FF0808'>=======================================</font>" >> /etc/bannerssh

echo -e "\033[01;31m ถ้าคริปไม่ทำงานให้รีสตาร์ท VPS แล้วติดตั้งใหม่\033[0m"

echo -e "\033[01;32mVPN-SSH ของคุณพร้อมใช้งานเเละ !! \033[0m"
echo -e "\033[01;33mคุณสามารถเพิ่มผู้ใช้โดยพิมพ์ accvpn เเละเปลี่ยนรหัสโดยพิมพ์ passwd !! \033[0m"
echo -e "\033[01;34mอย่าลืมกดติดตาม Otaku Mystery !! \033[0m"
echo -e "\033[01;35m-------------------------------------\033[0m"
echo -e "\033[01;36m--ตัวอย่างแบนเนอร์ข้อความ ขณะเชื่อมต่อ--\033[0m"
echo -e "\033[01;37m=======================================
VPN นี้ ทำงานบนระบบของ Otaku Mystery
เปลี่ยนข้อความนี้ได้ที่ /etc/bannerssh
แจกฟรี ห้ามจำหน่าย
=======================================
ติดตามเราได้ที่
Youtube: Otaku Mystery
=======================================\033[0m"
echo -e "\033[01;35m-------------------------------------\033[0m"
echo -e "\033[01;36m--ตัวอย่างแบนเนอร์ข้อความ ขณะเชื่อมต่อ--\033[0m"
echo -e "\033[01;37m=======================================
VPN นี้ ทำงานบนระบบของ Otaku Mystery
เปลี่ยนข้อความนี้ได้ที่ /etc/bannerssh
แจกฟรี ห้ามจำหน่าย
=======================================
ติดตามเราได้ที่
Youtube: Otaku Mystery
=======================================\033[0m"
exit 0
fi
