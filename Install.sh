#!/bin/bash

#Initializing var
if [[ "$USER" != 'root' ]]; then
	echo "Run Script By. GenesisPresent"
	exit
fi

if [[ -e /etc/debian_version ]]; then
	OS=debian
	RCLOCAL='/etc/rc.local'
elif [[ -e /etc/centos-release || -e /etc/redhat-release ]]; then
	OS=centos
	RCLOCAL='/etc/rc.d/rc.local'
	chmod +x /etc/rc.d/rc.local
else
	echo "This script installer only works on Debian and Centos system."
	exit
fi

#Requirement
if [ ! -e /usr/bin/curl ]; then
	if [[ "$OS" = 'debian' ]]; then
	apt-get -y update && apt-get -y install curl
	else
	yum -y update && yum -y install curl
	fi
fi

#Inisialisasi2
MYIP=$(curl -4 icanhazip.com)

# go to root
cd

#Start Installing
clear
echo ""
echo ""
echo ""
echo "Configure Database OCS Panel Name"
echo "(Make sure the database name contains no spaces, symbols, or special characters.)"
read -p "Database Name    : " -e -i GenesisPresent NamaDatabase
echo "Input MySQL Password:"
echo "(Use different Password for your database, dont use VPS password.)"
read -p "Database Password: " -e -i Password PasswordDatabase
echo ""
echo "All questions have been answered."
read -n1 -r -p "Press any key to continue ..."

cd
if [[ "$OS" = 'debian' ]]; then
	export DEBIAN_FRONTEND=noninteractive
	apt-get -y update
	apt-get -y install build-essential expect 
		
	#Install MySQL & Create Database
	apt-get install -y mysql-server
	#mysql_secure_installation
	so1=$(expect -c "
	spawn mysql_secure_installation; sleep 3
	expect \"\";  sleep 3; send \"\r\"
	expect \"\";  sleep 3; send \"Y\r\"
	expect \"\";  sleep 3; send \"$PasswordDatabase\r\"
	expect \"\";  sleep 3; send \"$PasswordDatabase\r\"
	expect \"\";  sleep 3; send \"Y\r\"
	expect \"\";  sleep 3; send \"Y\r\"
	expect \"\";  sleep 3; send \"Y\r\"
	expect \"\";  sleep 3; send \"Y\r\"
	expect eof; ")
	echo "$so1"
	#\r
	#Y
	#pass
	#pass
	#Y
	#Y
	#Y
	#Y
	chown -R mysql:mysql /var/lib/mysql/
	chmod -R 755 /var/lib/mysql/
	#mysql -u root -p
	so2=$(expect -c "
	spawn mysql -u root -p; sleep 3
	expect \"\";  sleep 3; send \"$PasswordDatabase\r\"
	expect \"\";  sleep 3; send \"CREATE DATABASE IF NOT EXISTS $NamaDatabase;EXIT;\r\"
	expect eof; ")
	echo "$so2"
	#pass
	#CREATE DATABASE IF NOT EXISTS OCS_PANEL;EXIT;


	#Install Webserver
	apt-get -y install nginx php5-fpm php5-cli php5-mysql php5-mcrypt
	rm -f /etc/nginx/sites-enabled/default
	rm -f /etc/nginx/sites-available/default
	mv /etc/nginx/nginx.conf /etc/nginx/nginx.conf.backup
	mv /etc/nginx/conf.d/vps.conf /etc/nginx/conf.d/vps.conf.backup
	wget -O /etc/nginx/nginx.conf "https://raw.githubusercontent.com/Apeachsan91/premium/master/nginx.conf"
	wget -O /etc/nginx/conf.d/vps.conf "https://raw.githubusercontent.com/lnwseed/ocs-topup/master/vps.conf"
	sed -i 's/cgi.fix_pathinfo=1/cgi.fix_pathinfo=0/g' /etc/php5/fpm/php.ini
	sed -i 's/listen = \/var\/run\/php5-fpm.sock/listen = 127.0.0.1:9000/g' /etc/php5/fpm/pool.d/www.conf
	useradd -m vps && mkdir -p /home/vps/public_html
	rm -f /home/vps/public_html/index.html && echo "<?php phpinfo() ?>" > /home/vps/public_html/info.php
	chown -R www-data:www-data /home/vps/public_html
	chmod -R g+rw /home/vps/public_html
	service php5-fpm restart
	service nginx restart

	#Install Git dan Ambil Script
	apt-get -y install zip unzip
	cd /home/vps/public_html
	wget https://www.mediafire.com/folder/0hi4oore6ck9d/ocd/ocspanel.zip
	unzip ocspanel.zip
	chmod 777 /home/vps/public_html/config
	chmod 777 /home/vps/public_html/config/config.ini
	chmod 777 /home/vps/public_html/config/route.ini

else
#######################################################################################################################################
#Jika Centos

	
	#Install MySQL & Create Database
	yum -y install mysql-server
	chown -R mysql:mysql /var/lib/mysql/
	chmod -R 755 /var/lib/mysql/
	chkconfig mysqld on
	service mysqld start
	#mysql_secure_installation
	so1=$(expect -c "
	spawn mysql_secure_installation; sleep 3
	expect \"\";  sleep 3; send \"\r\"
	expect \"\";  sleep 3; send \"Y\r\"
	expect \"\";  sleep 3; send \"$PasswordDatabase\r\"
	expect \"\";  sleep 3; send \"$PasswordDatabase\r\"
	expect \"\";  sleep 3; send \"Y\r\"
	expect \"\";  sleep 3; send \"Y\r\"
	expect \"\";  sleep 3; send \"Y\r\"
	expect \"\";  sleep 3; send \"Y\r\"
	expect eof; ")
	echo "$so1"
	#\r
	#Y
	#pass
	#pass
	#Y
	#Y
	#Y
	#Y
	so2=$(expect -c "
	spawn mysql -u root -p; sleep 3
	expect \"\";  sleep 3; send \"$PasswordDatabase\r\"
	expect \"\";  sleep 3; send \"CREATE DATABASE IF NOT EXISTS $NamaDatabase;EXIT;\r\"
	expect eof; ")
	echo "$so2"
	#pass
	#CREATE DATABASE IF NOT EXISTS OCS_PANEL;EXIT;

	#Install Webserver
	yum -y install nginx php php-fpm php-cli php-mysql php-mcrypt
	rm -f /usr/share/nginx/html/index.html
	mv /etc/nginx/nginx.conf /etc/nginx/nginx.conf.backup
	mv /etc/nginx/conf.d/vps.conf /etc/nginx/conf.d/vps.conf.backup
	wget -O /etc/nginx/nginx.conf "https://raw.githubusercontent.com/Apeachsan91/premium/master/nginx.conf"
	wget -O /etc/nginx/conf.d/vps.conf "https://raw.githubusercontent.com/Apeachsan91/premium/master/vps.conf"
	sed -i 's/www-data/nginx/g' /etc/nginx/nginx.conf
	sed -i 's/apache/nginx/g' /etc/php-fpm.d/www.conf
	sed -i 's/cgi.fix_pathinfo=1/cgi.fix_pathinfo=0/g' /etc/php.ini
	sed -i 's/;session.save_path = "/tmp"/session.save_path = "/tmp"/g' /etc/php.ini
	useradd -m vps && mkdir -p /home/vps/public_html
	rm -f /home/vps/public_html/index.html && echo "<?php phpinfo() ?>" > /home/vps/public_html/info.php
	chown -R nginx:nginx /home/vps/public_html
	chown nginx:nginx /var/lib/php/session
	chmod -R +rw /home/vps/public_html
	chmod -R +rw /home/vps/public_html/*
	chmod -R +rx /home/vps
	chkconfig nginx on
	chkconfig php-fpm on
		
	service php-fpm restart
	service nginx restart

	#Install Git dan Ambil Script
	yum -y install zip unzip
	cd /home/vps/public_html
	wget https://www.mediafire.com/folder/0hi4oore6ck9d/ocd/ocspanel.zip
	unzip ocspanel.zip
	chmod 777 /home/vps/public_html/config
	chmod 777 /home/vps/public_html/config/config.ini
	chmod 777 /home/vps/public_html/config/route.ini
fi

# OCS Panel Configuration
clear
echo "Configuration on VPS is done!"
echo "Now you have to configure OCS Panel through your browser!"
echo "Open Your Browser, go to http://$MYIP"
echo "Input the details of your Database"
echo "-----"
echo "Database:"
echo "- Database Host: localhost"
echo "- Database Name: $NamaDatabase"
echo "- Database User: root"
echo "- Database Pass: $PasswordDatabase"
echo ""
echo "Admin Login:"
echo "- Username: (Username of the OCS admin you like)"
echo "- Password: (password for OCS Admin Panel)"
echo "- Re-Enter Password: (Re-enter password)"
echo ""
echo "Press the Install button on the OCS Panel, and wait for the installation to complete."
echo "If you installed via browser, back to putty/juicessh, and then press [ENTER]!"
sleep 3
echo ""
read -p "If the above step has been done, please Press [Enter] key to continue... "
echo ""

#Delete Folder Install
rm -fR /home/vps/public_html/installation

#Delete History
cd
rm -f /root/.bash_history && history -c
rm -f /etc/sistem/secure/panel.sh
echo "unset HISTFILE" >> /etc/profile

# info
clear
echo ""
echo "--------------------------------------------------------------------------------"| tee -a log-install-ocspanel.txt
echo "Successfully installed" 								| tee -a log-install-ocspanel.txt
echo "Please login to your OCS Panels" 								| tee -a log-install-ocspanel.txt
echo "URL: http://$MYIP" 											| tee -a log-install-ocspanel.txt
echo "Username: (Use the username you have input in the browser)" 	| tee -a log-install-ocspanel.txt
echo "Password: (Use the password you have input in the browser)"    | tee -a log-install-ocspanel.txt
echo "" 																| tee -a log-install-ocspanel.txt
echo "Installatin Log: /root/log-install-ocspanel.txt" 				| tee -a log-install-ocspanel.txt
echo "--------------------------------------------------------------------------------"| tee -a log-install-ocspanel.txt
echo "Copyright GenesisPresent"  						| tee -a log-install-ocspanel.txt
echo "--------------------------------------------------------------------------------"| tee -a log-install-ocspanel.txt
echo ""
echo ""
cd
