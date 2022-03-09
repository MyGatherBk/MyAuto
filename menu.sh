#!/bin/bash

clear
GROUPNAME=nogroup
VERSION_ID=$(cat /etc/os-release | grep "VERSION_ID")
CHECKSYSTEM=$(tail -n +2 /etc/openvpn/server.conf | grep "^username-as-common-name")
IP=$(wget -4qO- "http://whatismyip.akamai.com/")
IP2="s/xxxxxxxxx/$IP/g";


# ads
echo ""
echo -e "${RED} =============== OS-32 & 64-bit =================    "
echo -e "${RED} #    OS  DEBIAN 8-9-10  OS  UBUNTU 14-16-18    #    "
echo -e "${RED} #         BY : Pirakit Khawpleum               #    "
echo -e "${RED} #    FB : https://m.me/pirakrit.khawplum       #    "
echo -e "${RED} =============== OS-32 & 64-bit =================    "
echo -e "${GREEN} ไอพีเซิฟ: $IP "
echo -e "${NC} "
echo -e "\033[0;34m━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━\033[0m"
chek=$(cat /etc/issue.net)
tram=$( free -m | awk 'NR==2 {print $2}' )
up=$(uptime|awk '{ $1=$2=$(NF-6)=$(NF-5)=$(NF-4)=$(NF-3)=$(NF-2)=$(NF-1)=$NF=""; print }')
echo -e "\e[032;1mSYSTEM OS:\e[0m  $chek" 
echo -e "\e[032;1mTotal Amount Of RAM:\e[0m $tram MB"
echo -e "\e[032;1mSystem Uptime:\e[0m $up"
echo -e "\033[0;34m━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━\033[0m" 
echo ""
echo ""              

	echo "-------------------------------------------------------" 
	echo "|||||||||||||||| MyGatherBK-VPN |||||||||||||||||" 
	echo "-------------------------------------------------------"
	echo -e "เมนูสคริปท์ ${GRAY}✿.｡.:* *.:｡✿*ﾟ’ﾟ･✿.｡.:*${NC}"
	echo ""
	echo "   1) Add a new client"
	echo "   2) Revoke an existing client"
	echo "   3) Remove OpenVPN"
	echo "   4) Exit"
	echo "  00) up"
	
	1) # ==================================================================================================================

echo ""
echo -e "${RED} =============== OS-32 & 64-bit =================    "
echo -e "${RED} #    OS  DEBIAN 8-9-10  OS  UBUNTU 14-16-18    #    "
echo -e "${RED} #         BY : Pirakit Khawpleum               #    "
echo -e "${RED} #    FB : https://m.me/pirakrit.khawplum       #    "
echo -e "${RED} =============== OS-32 & 64-bit =================    "
echo -e "${GREEN} ไอพีเซิฟ: $IP "
echo -e "${NC} "
echo ""
			echo
			echo "ระบุชื่อ client:"
			read -p "Name: " unsanitized_client
			client=$(sed 's/[^0123456789abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ_-]/_/g' <<< "$unsanitized_client")
			while [[ -z "$client" || -e /etc/openvpn/server/easy-rsa/pki/issued/"$client".crt ]]; do
				echo "$client: ชื่อไม่ถูกต้อง."
				read -p "Name: " unsanitized_client
				client=$(sed 's/[^0123456789abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ_-]/_/g' <<< "$unsanitized_client")
			done
			cd /etc/openvpn/server/easy-rsa/
			EASYRSA_CERT_EXPIRE=3650 ./easyrsa build-client-full "$client" nopass
			# Generates the custom client.ovpn
			echo
			echo "$client มีอยู่ใน:" ~/"$client.ovpn"
			exit
		;;

	2) # ==================================================================================================================
			# This option could be documented a bit better and maybe even be simplified
			# ...but what can I say, I want some sleep too
			number_of_clients=$(tail -n +2 /etc/openvpn/server/easy-rsa/pki/index.txt | grep -c "^V")
			if [[ "$number_of_clients" = 0 ]]; then
				echo
				echo "There are no existing clients!"
				exit
			fi
			echo
			echo "Select the client to revoke:"
			tail -n +2 /etc/openvpn/server/easy-rsa/pki/index.txt | grep "^V" | cut -d '=' -f 2 | nl -s ') '
			read -p "Client: " client_number
			until [[ "$client_number" =~ ^[0-9]+$ && "$client_number" -le "$number_of_clients" ]]; do
				echo "$client_number: invalid selection."
				read -p "Client: " client_number
			done
			client=$(tail -n +2 /etc/openvpn/server/easy-rsa/pki/index.txt | grep "^V" | cut -d '=' -f 2 | sed -n "$client_number"p)
			echo
			read -p "Confirm $client revocation? [y/N]: " revoke
			until [[ "$revoke" =~ ^[yYnN]*$ ]]; do
				echo "$revoke: invalid selection."
				read -p "Confirm $client revocation? [y/N]: " revoke
			done
			if [[ "$revoke" =~ ^[yY]$ ]]; then
				cd /etc/openvpn/server/easy-rsa/
				./easyrsa --batch revoke "$client"
				EASYRSA_CRL_DAYS=3650 ./easyrsa gen-crl
				rm -f /etc/openvpn/server/crl.pem
				cp /etc/openvpn/server/easy-rsa/pki/crl.pem /etc/openvpn/server/crl.pem
				# CRL is read with each client connection, when OpenVPN is dropped to nobody
				chown nobody:"$group_name" /etc/openvpn/server/crl.pem
				echo
				echo "$client revoked!"
			else
				echo
				echo "$client revocation aborted!"
			fi
			exit
		;;

	3) # ==================================================================================================================
echo
			read -p "Confirm OpenVPN removal? [y/N]: " remove
			until [[ "$remove" =~ ^[yYnN]*$ ]]; do
				echo "$remove: invalid selection."
				read -p "Confirm OpenVPN removal? [y/N]: " remove
			done
			if [[ "$remove" =~ ^[yY]$ ]]; then
				port=$(grep '^port ' /etc/openvpn/server/server.conf | cut -d " " -f 2)
				protocol=$(grep '^proto ' /etc/openvpn/server/server.conf | cut -d " " -f 2)
				if systemctl is-active --quiet firewalld.service; then
					ip=$(firewall-cmd --direct --get-rules ipv4 nat POSTROUTING | grep '\-s 10.8.0.0/24 '"'"'!'"'"' -d 10.8.0.0/24' | grep -oE '[^ ]+$')
					# Using both permanent and not permanent rules to avoid a firewalld reload.
					firewall-cmd --remove-port="$port"/"$protocol"
					firewall-cmd --zone=trusted --remove-source=10.8.0.0/24
					firewall-cmd --permanent --remove-port="$port"/"$protocol"
					firewall-cmd --permanent --zone=trusted --remove-source=10.8.0.0/24
					firewall-cmd --direct --remove-rule ipv4 nat POSTROUTING 0 -s 10.8.0.0/24 ! -d 10.8.0.0/24 -j SNAT --to "$ip"
					firewall-cmd --permanent --direct --remove-rule ipv4 nat POSTROUTING 0 -s 10.8.0.0/24 ! -d 10.8.0.0/24 -j SNAT --to "$ip"
					if grep -qs "server-ipv6" /etc/openvpn/server/server.conf; then
						ip6=$(firewall-cmd --direct --get-rules ipv6 nat POSTROUTING | grep '\-s fddd:1194:1194:1194::/64 '"'"'!'"'"' -d fddd:1194:1194:1194::/64' | grep -oE '[^ ]+$')
						firewall-cmd --zone=trusted --remove-source=fddd:1194:1194:1194::/64
						firewall-cmd --permanent --zone=trusted --remove-source=fddd:1194:1194:1194::/64
						firewall-cmd --direct --remove-rule ipv6 nat POSTROUTING 0 -s fddd:1194:1194:1194::/64 ! -d fddd:1194:1194:1194::/64 -j SNAT --to "$ip6"
						firewall-cmd --permanent --direct --remove-rule ipv6 nat POSTROUTING 0 -s fddd:1194:1194:1194::/64 ! -d fddd:1194:1194:1194::/64 -j SNAT --to "$ip6"
					fi
				else
					systemctl disable --now openvpn-iptables.service
					rm -f /etc/systemd/system/openvpn-iptables.service
				fi
				if sestatus 2>/dev/null | grep "Current mode" | grep -q "enforcing" && [[ "$port" != 1194 ]]; then
					semanage port -d -t openvpn_port_t -p "$protocol" "$port"
				fi
				systemctl disable --now openvpn-server@server.service
				rm -f /etc/systemd/system/openvpn-server@server.service.d/disable-limitnproc.conf
				rm -f /etc/sysctl.d/99-openvpn-forward.conf
				if [[ "$os" = "debian" || "$os" = "ubuntu" ]]; then
					rm -rf /etc/openvpn/server
					apt-get remove --purge -y openvpn
				else
					# Else, OS must be CentOS or Fedora
					yum remove -y openvpn
					rm -rf /etc/openvpn/server
				fi
				echo
				echo "OpenVPN removed!"
			else
				echo
				echo "OpenVPN removal aborted!"
			fi
			exit
		;;
	4) # ==================================================================================================================
			exit
		;;
	5) # ==================================================================================================================

		clear
echo ""
echo -e "${RED} =============== OS-32 & 64-bit =================    "
echo -e "${RED} #    OS  DEBIAN 8-9-10  OS  UBUNTU 14-16-18    #    "
echo -e "${RED} #         BY : Pirakit Khawpleum               #    "
echo -e "${RED} #    FB : https://m.me/pirakrit.khawplum       #    "
echo -e "${RED} =============== OS-32 & 64-bit =================    "
echo -e "${GREEN} ไอพีเซิฟ: $IP "
echo -e "${NC} "
echo ""
	read -p "ชื่อบัญชีที่ต้องการเปลี่ยนรหัสผ่าน : " CLIENTNAME
	egrep "^$CLIENTNAME" /etc/passwd >/dev/null

	if [ $? -eq 0 ]; then
		echo ""
		read -p "รหัสผ่านที่ต้องการปลี่ยน : " NEWPASSWORD
		read -p "ยืนยันรหัสผ่านอีกครั้ง : " RETYPEPASSWORD

		if [[ $NEWPASSWORD = $RETYPEPASSWORD ]]; then
			echo ""
			echo "ระบบได้ทำการเปลี่ยนรหัสผ่านเรียบร้อยแล้ว"
			echo ""
			echo "ชื่อบัญชีผู้ใข้ : $CLIENTNAME"
			echo "รหัสผ่านใหม่ : $NEWPASSWORD"
			echo ""
			exit
		else
			echo ""
			echo "เปลี่ยนรหัสผ่านไม่สำเร็จ การยืนยันรหัสผ่านไม่สอดคล้อง"
			echo ""
			exit
		fi
	else

		echo ""
		echo "ไม่มีชื่อบัญชีที่ระบุอยู่ในระบบ"
		echo ""
		read -p "กลับไปที่เมนู (Y or N) : " -e -i Y TOMENU

		if [[ "$TOMENU" = 'Y' ]]; then
			menu
			exit
		elif [[ "$TOMENU" = 'N' ]]; then
			exit
		fi
	fi

	;;

	6) # ==================================================================================================================

		clear
echo ""
echo -e "${RED} =============== OS-32 & 64-bit =================    "
echo -e "${RED} #    OS  DEBIAN 8-9-10  OS  UBUNTU 14-16-18    #    "
echo -e "${RED} #         BY : Pirakit Khawpleum               #    "
echo -e "${RED} #    FB : https://m.me/pirakrit.khawplum       #    "
echo -e "${RED} =============== OS-32 & 64-bit =================    "
echo -e "${GREEN} ไอพีเซิฟ: $IP "
echo -e "${NC} "
echo ""
read -p "ชื่อบัญชีที่ต้องการเปลี่ยนวันหมดอายุ : " -e CLIENT

if [ $? -eq 0 ]; then
	EXP="$(chage -l $CLIENT | grep "Account expires" | awk -F": " '{print $2}')"
	echo ""
	echo -e "ชื่อบัญชีนี้หมดอายุในวันที่ ${GRAY}$EXP${NC}"
	echo ""
	read -p "เปลี่ยนวันหมดอายุ : " -e TimeActive
	userdel $CLIENT
	useradd -e `date -d "$TimeActive days" +"%Y-%m-%d"` -s /bin/false -M $CLIENT
	EXP="$(chage -l $CLIENT | grep "Account expires" | awk -F": " '{print $2}')"
	echo -e "$CLIENT\n$CLIENT\n"|passwd $CLIENT &> /dev/null
	echo ""
	echo "ชื่อบัญชี : $CLIENT"
	echo "หมดวันหมดในวันที่ : $EXP"
	echo ""
	exit

else

	echo ""
	echo "ไม่มีชื่อบัญชีที่ระบุอยู่ในระบบ"
	echo ""
	read -p "กลับไปที่เมนู (Y or N) : " -e -i Y TOMENU

	if [[ "$TOMENU" = 'Y' ]]; then
		menu
		exit
	elif [[ "$TOMENU" = 'N' ]]; then
		exit
	fi
fi

	;;

	7) # ==================================================================================================================

		clear
echo ""
echo -e "${RED} =============== OS-32 & 64-bit =================    "
echo -e "${RED} #    OS  DEBIAN 8-9-10  OS  UBUNTU 14-16-18    #    "
echo -e "${RED} #         BY : Pirakit Khawpleum               #    "
echo -e "${RED} #    FB : https://m.me/pirakrit.khawplum       #    "
echo -e "${RED} =============== OS-32 & 64-bit =================    "
echo -e "${GREEN} ไอพีเซิฟ: $IP "
echo -e "${NC} "
echo ""
 if [ ! -e /usr/local/bin/Reboot-Server ]; then
	echo '#!/bin/bash' > /usr/local/bin/Reboot-Server
	echo '' >> /usr/local/bin/Reboot-Server
	echo 'DATE=$(date +"%m-%d-%Y")' >> /usr/local/bin/Reboot-Server
	echo 'TIME=$(date +"%T")' >> /usr/local/bin/Reboot-Server
	echo 'echo "รีบูทเมื่อวันที่ $DATE เวลา $TIME" >> /usr/local/bin/Reboot-Log' >> /usr/local/bin/Reboot-Server
	echo '/sbin/shutdown -r now' >> /usr/local/bin/Reboot-Server
	chmod +x /usr/local/bin/Reboot-Server
fi

		clear
echo ""
echo -e "${RED} =============== OS-32 & 64-bit =================    "
echo -e "${RED} #    OS  DEBIAN 8-9-10  OS  UBUNTU 14-16-18    #    "
echo -e "${RED} #         BY : Pirakit Khawpleum               #    "
echo -e "${RED} #    FB : https://m.me/pirakrit.khawplum       #    "
echo -e "${RED} =============== OS-32 & 64-bit =================    "
echo -e "${GREEN} ไอพีเซิฟ: $IP "
echo -e "${NC} "
echo ""
echo -e "${GRAY}ตั้งค่าเวลารีบูทเซิฟเวอร์อัตโนมัติ ${NC} "
echo ""
echo -e "|${GRAY}1${NC}| รีบูททุกๆ  1 ชั่วโมง"
echo -e "|${GRAY}2${NC}| รีบูททุกๆ  6 ชั่วโมง"
echo -e "|${GRAY}3${NC}| รีบูททุกๆ 12 ชั่วโมง"
echo -e "|${GRAY}4${NC}| รีบูททุกๆ  1 วัน"
echo -e "|${GRAY}5${NC}| รีบูททุกๆ  7 วัน"
echo -e "|${GRAY}6${NC}| รีบูททุกๆ 30 วัน"
echo -e "|${GRAY}7${NC}| หยุดการรีบูทเซิฟเวอร์"
echo -e "|${GRAY}8${NC}| ตรวจสอบดูบันทึกการรีบูทเซิฟเวอร์"
echo -e "|${GRAY}9${NC}| ลบบันทึกการรีบูทเซิฟเวอร์"
echo ""
read -p "เลือกหัวข้อที่ต้องการใช้งาน : " REBOOT

case $REBOOT in

	1)

echo "0 * * * * root /usr/local/bin/Reboot-Server" > /etc/cron.d/Reboot-Server
echo ""
echo "ตั้งค่ารีบูทเซิฟเวอร์ทุกๆ 1 ชั่วโมงเรียบร้อยแล้ว"
echo ""
exit

	;;

	2)

echo "0 */6 * * * root /usr/local/bin/Reboot-Server" > /etc/cron.d/Reboot-Server
echo ""
echo "ตั้งค่ารีบูทเซิฟเวอร์ทุกๆ 6 ชั่วโมงเรียบร้อยแล้ว"
echo ""
exit

	;;

	3)

echo "0 */12 * * * root /usr/local/bin/Reboot-Server" > /etc/cron.d/Reboot-Server
echo ""
echo "ตั้งค่ารีบูทเซิฟเวอร์ทุกๆ 12 ชั่วโมงเรียบร้อยแล้ว"
echo ""
exit

	;;

	4)

echo "0 0 * * * root /usr/local/bin/Reboot-Server" > /etc/cron.d/Reboot-Server
echo ""
echo "ตั้งค่ารีบูทเซิฟเวอร์ทุกๆ 1 วันเรียบร้อยแล้ว"
echo ""
exit

	;;

	5)

echo "0 0 * * MON root /usr/local/bin/Reboot-Server" > /etc/cron.d/Reboot-Server
echo ""
echo "ตั้งค่ารีบูทเซิฟเวอร์ทุกๆ 7 วันเรียบร้อยแล้ว"
echo ""
exit

	;;

	6)

echo "0 0 1 * * root /usr/local/bin/Reboot-Server" > /etc/cron.d/Reboot-Server
echo ""
echo "ตั้งค่ารีบูทเซิฟเวอร์ทุกๆ 30 วันเรียบร้อยแล้ว"
echo ""
exit

	;;

	7)

rm -rf /usr/local/bin/Reboot-Server
echo ""
echo "หยุดการรีบูทเซิฟเวอร์เรียบร้อยแล้ว"
echo ""
exit

	;;

	8)

if [[ ! -e /usr/local/bin/Reboot-Log ]]; then
	echo ""
	echo "ไม่มีบันทึกการรีบูทเซิฟเวอร์"
	echo ""
	exit
else
	echo ""
	cat /usr/local/bin/Reboot-Log
	echo ""
	exit
fi

	;;

	9)

rm -rf /usr/local/bin/Reboot-Log
echo ""
echo "ลบบันทึกการรีบูทเซิฟเวอร์เรียบร้อยแล้ว"
echo ""
exit

	;;

esac

	;;

	8) # ==================================================================================================================

if [[ -e /usr/local/bin/speedtest ]]; then
	clear
	speedtest --share
elif [[ ! -e /usr/local/bin/speedtest ]]; then
	wget -O /usr/local/bin/speedtest "https://raw.githubusercontent.com/nwqionm/OPENEXTRA/master/Speedtest"
	chmod +x /usr/local/bin/speedtest
	clear
	speedtest --share
fi

	;;

	9) # ==================================================================================================================

# Banner
rm /etc/bannerssh
wget -O /etc/bannerssh "https://raw.githubusercontent.com/MyGatherBk/MyAuto/master/issue.net"
echo "Banner /etc/bannerssh" >> /etc/ssh/sshd_config
service ssh restart

	;;
	


	10) # ==================================================================================================================

INTERFACE=`ifconfig | head -n1 | awk '{print $1}' | cut -d ':' -f 1`
TODAY=$(vnstat -i $INTERFACE | grep "today" | awk '{print $8" "substr ($9, 1, 1)}')
YESTERDAY=$(vnstat -i $INTERFACE | grep "yesterday" | awk '{print $8" "substr ($9, 1, 1)}')
WEEK=$(vnstat -i $INTERFACE -w | grep "current week" | awk '{print $9" "substr ($10, 1, 1)}')
RXWEEK=$(vnstat -i $INTERFACE -w | grep "current week" | awk '{print $3" "substr ($10, 1, 1)}')
TXWEEK=$(vnstat -i $INTERFACE -w | grep "current week" | awk '{print $6" "substr ($10, 1, 1)}')
MOUNT=$(vnstat -i $INTERFACE | grep "`date +"%b '%y"`" | awk '{print $9" "substr ($10, 1, 1)}')
RXMOUNT=$(vnstat -i $INTERFACE | grep "`date +"%b '%y"`" | awk '{print $3" "substr ($10, 1, 1)}')
TXMOUNT=$(vnstat -i $INTERFACE | grep "`date +"%b '%y"`" | awk '{print $6" "substr ($10, 1, 1)}')
TOTAL=$(vnstat -i $INTERFACE | grep "total:" | awk '{print $8" "substr ($9, 1, 1)}')
RXTOTAL=$(vnstat -i $INTERFACE | grep "rx:" | awk '{print $2" "substr ($9, 1, 1)}')
TXTOTAL=$(vnstat -i $INTERFACE | grep "tx:" | awk '{print $5" "substr ($9, 1, 1)}')

		clear
echo ""
echo -e "${RED} =============== OS-32 & 64-bit =================    "
echo -e "${RED} #    OS  DEBIAN 8-9-10  OS  UBUNTU 14-16-18    #    "
echo -e "${RED} #         BY : Pirakit Khawpleum               #    "
echo -e "${RED} #    FB : https://m.me/pirakrit.khawplum       #    "
echo -e "${RED} =============== OS-32 & 64-bit =================    "
echo -e "${GREEN} ไอพีเซิฟ: $IP "
echo -e "${NC} "
echo ""
if [[ -e /usr/local/bin/Check-Thai ]]; then
	echo -e "แบนด์วิดท์ ${GRAY}✿.｡.:* *.:｡✿*ﾟ’ﾟ･✿.｡.:*${NC}"
	echo ""
	echo -e "วันนี้ ${GRAY}$TODAY${NC}"
	echo -e "เมื่อวานนี้ ${GRAY}$YESTERDAY${NC}"
	echo ""
	echo -e "รับข้อมูล (rx) ${GRAY}$RXWEEK${NC} ส่งข้อมูล (tx) ${GRAY}$TXWEEK${NC}"
	echo -e "สัปดาห์นี้ ${GRAY}$WEEK${NC}"
	echo ""
	echo -e "รับข้อมูล (rx) ${GRAY}$RXMOUNT${NC} ส่งข้อมูล (tx) ${GRAY}$TXMOUNT${NC}"
	echo -e "รวมทั้งหมดเฉพาะเดือนนี้ ${GRAY}$MOUNT${NC}"
	echo ""
	echo -e "รับข้อมูล (rx) ${GRAY}$RXTOTAL${NC} ส่งข้อมูล (tx) ${GRAY}$TXTOTAL${NC}"
	echo -e "รวมทั้งหมด ${GRAY}$TOTAL${NC}"
	echo ""
	exit

elif [[ ! -e /usr/local/bin/Check-Thai ]]; then
	echo -e "BANDWIDTH ${GRAY}✿.｡.:* *.:｡✿*ﾟ’ﾟ･✿.｡.:*${NC}"
	echo ""
	echo -e "TODAY ${GRAY}$TODAY${NC}"
	echo -e "YESTERDAY ${GRAY}$YESTERDAY${NC}"
	echo ""
	echo -e "RECEIVE (rx) ${GRAY}$RXWEEK${NC} TRANSMIT (tx) ${GRAY}$TXWEEK${NC}"
	echo -e "CURRENT WEEK ${GRAY}$WEEK${NC}"
	echo ""
	echo -e "RECEIVE (rx) ${GRAY}$RXMOUNT${NC} TRANSMIT (tx) ${GRAY}$TXMOUNT${NC}"
	echo -e "THIS MOUNT TOTAL ${GRAY}$MOUNT${NC}"
	echo ""
	echo -e "RECEIVE (rx) ${GRAY}$RXTOTAL${NC} TRANSMIT (tx) ${GRAY}$TXTOTAL${NC}"
	echo -e "TOTAL ${GRAY}$TOTAL${NC}"
	echo ""
	exit
fi

	;;

	11) # ==================================================================================================================

DATE1=$(vnstat -h | sed -n '16p' | awk '{print $1}')
RX1=$(vnstat -h | sed -n '16p' | awk '{print $2}' | cut -d ',' -f 1-20 --output-delimiter='')
TX1=$(vnstat -h | sed -n '16p' | awk '{print $3}' | cut -d ',' -f 1-20 --output-delimiter='')
CONRX1=$(echo "scale=2;$RX1 / 1000000" | bc)
CONTX1=$(echo "scale=2;$TX1 / 1000000" | bc)

DATE2=$(vnstat -h | sed -n '17p' | awk '{print $1}')
RX2=$(vnstat -h | sed -n '17p' | awk '{print $2}' | cut -d ',' -f 1-20 --output-delimiter='')
TX2=$(vnstat -h | sed -n '17p' | awk '{print $3}' | cut -d ',' -f 1-20 --output-delimiter='')
CONRX2=$(echo "scale=2;$RX2 / 1000000" | bc)
CONTX2=$(echo "scale=2;$TX2 / 1000000" | bc)

DATE3=$(vnstat -h | sed -n '18p' | awk '{print $1}')
RX3=$(vnstat -h | sed -n '18p' | awk '{print $2}' | cut -d ',' -f 1-20 --output-delimiter='')
TX3=$(vnstat -h | sed -n '18p' | awk '{print $3}' | cut -d ',' -f 1-20 --output-delimiter='')
CONRX3=$(echo "scale=2;$RX3 / 1000000" | bc)
CONTX3=$(echo "scale=2;$TX3 / 1000000" | bc)

DATE4=$(vnstat -h | sed -n '19p' | awk '{print $1}')
RX4=$(vnstat -h | sed -n '19p' | awk '{print $2}' | cut -d ',' -f 1-20 --output-delimiter='')
TX4=$(vnstat -h | sed -n '19p' | awk '{print $3}' | cut -d ',' -f 1-20 --output-delimiter='')
CONRX4=$(echo "scale=2;$RX4 / 1000000" | bc)
CONTX4=$(echo "scale=2;$TX4 / 1000000" | bc)

DATE5=$(vnstat -h | sed -n '20p' | awk '{print $1}')
RX5=$(vnstat -h | sed -n '20p' | awk '{print $2}' | cut -d ',' -f 1-20 --output-delimiter='')
TX5=$(vnstat -h | sed -n '20p' | awk '{print $3}' | cut -d ',' -f 1-20 --output-delimiter='')
CONRX5=$(echo "scale=2;$RX4 / 1000000" | bc)
CONTX5=$(echo "scale=2;$TX4 / 1000000" | bc)

DATE6=$(vnstat -h | sed -n '21p' | awk '{print $1}')
RX6=$(vnstat -h | sed -n '21p' | awk '{print $2}' | cut -d ',' -f 1-20 --output-delimiter='')
TX6=$(vnstat -h | sed -n '21p' | awk '{print $3}' | cut -d ',' -f 1-20 --output-delimiter='')
CONRX6=$(echo "scale=2;$RX6 / 1000000" | bc)
CONTX6=$(echo "scale=2;$TX6 / 1000000" | bc)

DATE7=$(vnstat -h | sed -n '22p' | awk '{print $1}')
RX7=$(vnstat -h | sed -n '22p' | awk '{print $2}' | cut -d ',' -f 1-20 --output-delimiter='')
TX7=$(vnstat -h | sed -n '22p' | awk '{print $3}' | cut -d ',' -f 1-20 --output-delimiter='')
CONRX7=$(echo "scale=2;$RX7 / 1000000" | bc)
CONTX7=$(echo "scale=2;$TX7 / 1000000" | bc)

DATE8=$(vnstat -h | sed -n '23p' | awk '{print $1}')
RX8=$(vnstat -h | sed -n '23p' | awk '{print $2}' | cut -d ',' -f 1-20 --output-delimiter='')
TX8=$(vnstat -h | sed -n '23p' | awk '{print $3}' | cut -d ',' -f 1-20 --output-delimiter='')
CONRX8=$(echo "scale=2;$RX8 / 1000000" | bc)
CONTX8=$(echo "scale=2;$TX8 / 1000000" | bc)

DATE9=$(vnstat -h | sed -n '16p' | awk '{print $4}')
RX9=$(vnstat -h | sed -n '16p' | awk '{print $5}' | cut -d ',' -f 1-20 --output-delimiter='')
TX9=$(vnstat -h | sed -n '16p' | awk '{print $6}' | cut -d ',' -f 1-20 --output-delimiter='')
CONRX9=$(echo "scale=2;$RX9 / 1000000" | bc)
CONTX9=$(echo "scale=2;$TX9 / 1000000" | bc)

DATE10=$(vnstat -h | sed -n '17p' | awk '{print $4}')
RX10=$(vnstat -h | sed -n '17p' | awk '{print $5}' | cut -d ',' -f 1-20 --output-delimiter='')
TX10=$(vnstat -h | sed -n '17p' | awk '{print $6}' | cut -d ',' -f 1-20 --output-delimiter='')
CONRX10=$(echo "scale=2;$RX10 / 1000000" | bc)
CONTX10=$(echo "scale=2;$TX10 / 1000000" | bc)

DATE11=$(vnstat -h | sed -n '18p' | awk '{print $4}')
RX11=$(vnstat -h | sed -n '18p' | awk '{print $5}' | cut -d ',' -f 1-20 --output-delimiter='')
TX11=$(vnstat -h | sed -n '18p' | awk '{print $6}' | cut -d ',' -f 1-20 --output-delimiter='')
CONRX11=$(echo "scale=2;$RX11 / 1000000" | bc)
CONTX11=$(echo "scale=2;$TX11 / 1000000" | bc)

DATE12=$(vnstat -h | sed -n '19p' | awk '{print $4}')
RX12=$(vnstat -h | sed -n '19p' | awk '{print $5}' | cut -d ',' -f 1-20 --output-delimiter='')
TX12=$(vnstat -h | sed -n '19p' | awk '{print $6}' | cut -d ',' -f 1-20 --output-delimiter='')
CONRX12=$(echo "scale=2;$RX12 / 1000000" | bc)
CONTX12=$(echo "scale=2;$TX12 / 1000000" | bc)

DATE13=$(vnstat -h | sed -n '20p' | awk '{print $4}')
RX13=$(vnstat -h | sed -n '20p' | awk '{print $5}' | cut -d ',' -f 1-20 --output-delimiter='')
TX13=$(vnstat -h | sed -n '20p' | awk '{print $6}' | cut -d ',' -f 1-20 --output-delimiter='')
CONRX13=$(echo "scale=2;$RX13 / 1000000" | bc)
CONTX13=$(echo "scale=2;$TX13 / 1000000" | bc)

DATE14=$(vnstat -h | sed -n '21p' | awk '{print $4}')
RX14=$(vnstat -h | sed -n '21p' | awk '{print $5}' | cut -d ',' -f 1-20 --output-delimiter='')
TX14=$(vnstat -h | sed -n '21p' | awk '{print $6}' | cut -d ',' -f 1-20 --output-delimiter='')
CONRX14=$(echo "scale=2;$RX14 / 1000000" | bc)
CONTX14=$(echo "scale=2;$TX14 / 1000000" | bc)

DATE15=$(vnstat -h | sed -n '22p' | awk '{print $4}')
RX15=$(vnstat -h | sed -n '22p' | awk '{print $5}' | cut -d ',' -f 1-20 --output-delimiter='')
TX15=$(vnstat -h | sed -n '22p' | awk '{print $6}' | cut -d ',' -f 1-20 --output-delimiter='')
CONRX15=$(echo "scale=2;$RX15 / 1000000" | bc)
CONTX15=$(echo "scale=2;$TX15 / 1000000" | bc)

DATE16=$(vnstat -h | sed -n '23p' | awk '{print $4}')
RX16=$(vnstat -h | sed -n '23p' | awk '{print $5}' | cut -d ',' -f 1-20 --output-delimiter='')
TX16=$(vnstat -h | sed -n '23p' | awk '{print $6}' | cut -d ',' -f 1-20 --output-delimiter='')
CONRX16=$(echo "scale=2;$RX16 / 1000000" | bc)
CONTX16=$(echo "scale=2;$TX16 / 1000000" | bc)

DATE17=$(vnstat -h | sed -n '16p' | awk '{print $7}')
RX17=$(vnstat -h | sed -n '16p' | awk '{print $8}' | cut -d ',' -f 1-20 --output-delimiter='')
TX17=$(vnstat -h | sed -n '16p' | awk '{print $9}' | cut -d ',' -f 1-20 --output-delimiter='')
CONRX17=$(echo "scale=2;$RX17 / 1000000" | bc)
CONTX17=$(echo "scale=2;$TX17 / 1000000" | bc)

DATE18=$(vnstat -h | sed -n '17p' | awk '{print $7}')
RX18=$(vnstat -h | sed -n '17p' | awk '{print $8}' | cut -d ',' -f 1-20 --output-delimiter='')
TX18=$(vnstat -h | sed -n '17p' | awk '{print $9}' | cut -d ',' -f 1-20 --output-delimiter='')
CONRX18=$(echo "scale=2;$RX18 / 1000000" | bc)
CONTX18=$(echo "scale=2;$TX18 / 1000000" | bc)

DATE19=$(vnstat -h | sed -n '18p' | awk '{print $7}')
RX19=$(vnstat -h | sed -n '18p' | awk '{print $8}' | cut -d ',' -f 1-20 --output-delimiter='')
TX19=$(vnstat -h | sed -n '18p' | awk '{print $9}' | cut -d ',' -f 1-20 --output-delimiter='')
CONRX19=$(echo "scale=2;$RX19 / 1000000" | bc)
CONTX19=$(echo "scale=2;$TX19 / 1000000" | bc)

DATE20=$(vnstat -h | sed -n '19p' | awk '{print $7}')
RX20=$(vnstat -h | sed -n '19p' | awk '{print $8}' | cut -d ',' -f 1-20 --output-delimiter='')
TX20=$(vnstat -h | sed -n '19p' | awk '{print $9}' | cut -d ',' -f 1-20 --output-delimiter='')
CONRX20=$(echo "scale=2;$RX20 / 1000000" | bc)
CONTX20=$(echo "scale=2;$TX20 / 1000000" | bc)

DATE21=$(vnstat -h | sed -n '20p' | awk '{print $7}')
RX21=$(vnstat -h | sed -n '20p' | awk '{print $8}' | cut -d ',' -f 1-20 --output-delimiter='')
TX21=$(vnstat -h | sed -n '20p' | awk '{print $9}' | cut -d ',' -f 1-20 --output-delimiter='')
CONRX21=$(echo "scale=2;$RX21 / 1000000" | bc)
CONTX21=$(echo "scale=2;$TX21 / 1000000" | bc)

DATE22=$(vnstat -h | sed -n '21p' | awk '{print $7}')
RX22=$(vnstat -h | sed -n '21p' | awk '{print $8}' | cut -d ',' -f 1-20 --output-delimiter='')
TX22=$(vnstat -h | sed -n '21p' | awk '{print $9}' | cut -d ',' -f 1-20 --output-delimiter='')
CONRX22=$(echo "scale=2;$RX22 / 1000000" | bc)
CONTX22=$(echo "scale=2;$TX22 / 1000000" | bc)

DATE23=$(vnstat -h | sed -n '22p' | awk '{print $7}')
RX23=$(vnstat -h | sed -n '22p' | awk '{print $8}' | cut -d ',' -f 1-20 --output-delimiter='')
TX23=$(vnstat -h | sed -n '22p' | awk '{print $9}' | cut -d ',' -f 1-20 --output-delimiter='')
CONRX23=$(echo "scale=2;$RX23 / 1000000" | bc)
CONTX23=$(echo "scale=2;$TX23 / 1000000" | bc)

DATE24=$(vnstat -h | sed -n '23p' | awk '{print $7}')
RX24=$(vnstat -h | sed -n '23p' | awk '{print $8}' | cut -d ',' -f 1-20 --output-delimiter='')
TX24=$(vnstat -h | sed -n '23p' | awk '{print $9}' | cut -d ',' -f 1-20 --output-delimiter='')
CONRX24=$(echo "scale=2;$RX24 / 1000000" | bc)
CONTX24=$(echo "scale=2;$TX24 / 1000000" | bc)

		clear
echo ""
echo -e "${RED} =============== OS-32 & 64-bit =================    "
echo -e "${RED} #    OS  DEBIAN 8-9-10  OS  UBUNTU 14-16-18    #    "
echo -e "${RED} #         BY : Pirakit Khawpleum               #    "
echo -e "${RED} #    FB : https://m.me/pirakrit.khawplum       #    "
echo -e "${RED} =============== OS-32 & 64-bit =================    "
echo -e "${GREEN} ไอพีเซิฟ: $IP "
echo -e "${NC} "
echo ""
NOW=`echo -e "${GRAY}เวลาปัจจุบัน${NC}"`
echo ""
echo -e "${GRAY}ตัวเลขรับและส่งข้อมูลที่แสดงจะมีหน่วยวัดปริมาณเป็น Gigabyte ทั้งหมด${NC}"
printf "%-7s %-7s %-10s\n" "เวลา" "รับข้อมูล" "ส่งข้อมูล"
echo ""
printf "%-3s %-6s %-10s\n" "$DATE1" "$CONRX1" "$CONTX1"
printf "%-3s %-6s %-10s\n" "$DATE2" "$CONRX2" "$CONTX2"
printf "%-3s %-6s %-10s\n" "$DATE3" "$CONRX3" "$CONTX3"
printf "%-3s %-6s %-10s\n" "$DATE4" "$CONRX4" "$CONTX4"
printf "%-3s %-6s %-10s\n" "$DATE5" "$CONRX5" "$CONTX5"
printf "%-3s %-6s %-10s\n" "$DATE6" "$CONRX6" "$CONTX6"
printf "%-3s %-6s %-10s\n" "$DATE7" "$CONRX7" "$CONTX7"
printf "%-3s %-6s %-10s\n" "$DATE8" "$CONRX8" "$CONTX8"
printf "%-3s %-6s %-10s\n" "$DATE9" "$CONRX9" "$CONTX9"
printf "%-3s %-6s %-10s\n" "$DATE10" "$CONRX10" "$CONTX10"
printf "%-3s %-6s %-10s\n" "$DATE11" "$CONRX11" "$CONTX11"
printf "%-3s %-6s %-10s\n" "$DATE12" "$CONRX12" "$CONTX12"
printf "%-3s %-6s %-10s\n" "$DATE13" "$CONRX13" "$CONTX13"
printf "%-3s %-6s %-10s\n" "$DATE14" "$CONRX14" "$CONTX14"
printf "%-3s %-6s %-10s\n" "$DATE15" "$CONRX15" "$CONTX15"
printf "%-3s %-6s %-10s\n" "$DATE16" "$CONRX16" "$CONTX16"
printf "%-3s %-6s %-10s\n" "$DATE17" "$CONRX17" "$CONTX17"
printf "%-3s %-6s %-10s\n" "$DATE18" "$CONRX18" "$CONTX18"
printf "%-3s %-6s %-10s\n" "$DATE19" "$CONRX19" "$CONTX19"
printf "%-3s %-6s %-10s\n" "$DATE20" "$CONRX20" "$CONTX20"
printf "%-3s %-6s %-10s\n" "$DATE21" "$CONRX21" "$CONTX21"
printf "%-3s %-6s %-10s\n" "$DATE22" "$CONRX22" "$CONTX22"
printf "%-3s %-6s %-10s\n" "$DATE23" "$CONRX23" "$CONTX23"
printf "%-3s %-6s %-5s %-5s\n" "$DATE24" "$CONRX24" "$CONTX24" "< $NOW"
echo ""
exit

	;;

	12) # ==================================================================================================================

		clear
echo ""
echo -e "${RED} =============== OS-32 & 64-bit =================    "
echo -e "${RED} #    OS  DEBIAN 8-9-10  OS  UBUNTU 14-16-18    #    "
echo -e "${RED} #         BY : Pirakit Khawpleum               #    "
echo -e "${RED} #    FB : https://m.me/pirakrit.khawplum       #    "
echo -e "${RED} =============== OS-32 & 64-bit =================    "
echo -e "${GREEN} ไอพีเซิฟ: $IP "
echo -e "${NC} "
echo ""
if [[ ! -e /usr/local/bin/Banwidth-Per-Client ]]; then
	apt-get install python
	wget -O /usr/local/bin/Banwidth-Per-Client "https://raw.githubusercontent.com/nwqionm/OPENEXTRA/master/Banwidth-Per-Client"
	chmod +x /usr/local/bin/Banwidth-Per-Client
	clear
	echo ""
	echo -e "Script by ${GRAY}Weerawat Khlaolamom (P'Beer) ${NC}"
	echo -e "FB Group : ${GRAY}https://www.facebook.com/groups/143457819538014/ ${NC}"
	echo ""
	Banwidth-Per-Client
	echo ""
else
	clear
	echo ""
	echo -e "Script by ${GRAY}Weerawat Khlaolamom (P'Beer) ${NC}"
	echo -e "FB Group : ${GRAY}https://www.facebook.com/groups/143457819538014/ ${NC}"
	echo ""
	Banwidth-Per-Client
	echo ""
fi

	;;

	13) # ==================================================================================================================

		clear
echo ""
echo -e "${RED} =============== OS-32 & 64-bit =================    "
echo -e "${RED} #    OS  DEBIAN 8-9-10  OS  UBUNTU 14-16-18    #    "
echo -e "${RED} #         BY : Pirakit Khawpleum               #    "
echo -e "${RED} #    FB : https://m.me/pirakrit.khawplum       #    "
echo -e "${RED} =============== OS-32 & 64-bit =================    "
echo -e "${GREEN} ไอพีเซิฟ: $IP "
echo -e "${NC} "
echo ""
echo -e "${GRAY}ปรับเปลี่ยนระบบของเซิฟเวอร์ ${NC} "
echo ""
echo -e "|${GRAY}1${NC}| 1 ไฟล์เชื่อมต่อได้ 1 เครื่องเท่านั้น สามารถสร้างไฟล์เพิ่มได้"
echo -e "|${GRAY}2${NC}| 1 ไฟล์เชื่อมต่อได้หลายเครื่อง แต่ต้องสร้างบัญชีเพื่อใช้เชื่อมต่อ"
echo -e "|${GRAY}3${NC}| 1 ไฟล์เชื่อมต่อได้ไม่จำกัดเครื่อง"
echo ""
read -p "เลือกหัวข้อที่ต้องการใช้งาน : " CHANGESYSTEMSERVER

case $CHANGESYSTEMSERVER in

	1)

sed -i '28d' /etc/openvpn/server.conf
sed -i '28d' /etc/openvpn/server.conf
sed -i '28d' /etc/openvpn/server.conf
sed -i '20d' /etc/openvpn/client-common.txt
echo "client-to-client" >> /etc/openvpn/server.conf
echo ""
echo "ปรับเปลี่ยนระบบของเซิฟเวอร์เป็นรูปแบบที่ 1 เรียบร้อย"
echo ""
service openvpn restart

	;;

	2)

sed -i '28d' /etc/openvpn/server.conf
sed -i '28d' /etc/openvpn/server.conf
sed -i '28d' /etc/openvpn/server.conf
sed -i '20d' /etc/openvpn/client-common.txt
if [[ "$VERSION_ID" = 'VERSION_ID="7"' ]]; then
	echo "plugin /usr/lib/openvpn/openvpn-auth-pam.so /etc/pam.d/login" >> /etc/openvpn/server.conf
	echo "client-cert-not-required" >> /etc/openvpn/server.conf
	echo "username-as-common-name" >> /etc/openvpn/server.conf
else
	echo "plugin /usr/lib/openvpn/openvpn-plugin-auth-pam.so /etc/pam.d/login" >> /etc/openvpn/server.conf
	echo "client-cert-not-required" >> /etc/openvpn/server.conf
	echo "username-as-common-name" >> /etc/openvpn/server.conf
fi
echo "auth-user-pass" >> /etc/openvpn/client-common.txt
echo ""
echo "ปรับเปลี่ยนระบบของเซิฟเวอร์เป็นรูปแบบที่ 2 เรียบร้อย"
echo ""
service openvpn restart

	;;

	3)

sed -i '28d' /etc/openvpn/server.conf
sed -i '28d' /etc/openvpn/server.conf
sed -i '28d' /etc/openvpn/server.conf
sed -i '20d' /etc/openvpn/client-common.txt
echo "duplicate-cn" >> /etc/openvpn/server.conf
echo ""
echo "ปรับเปลี่ยนระบบของเซิฟเวอร์เป็นรูปแบบที่ 3 เรียบร้อย"
echo ""
service openvpn restart

	;;

esac

	;;

	14) # ==================================================================================================================

		clear
echo ""
echo -e "${RED} =============== OS-32 & 64-bit =================    "
echo -e "${RED} #    OS  DEBIAN 8-9-10  OS  UBUNTU 14-16-18    #    "
echo -e "${RED} #         BY : Pirakit Khawpleum               #    "
echo -e "${RED} #    FB : https://m.me/pirakrit.khawplum       #    "
echo -e "${RED} =============== OS-32 & 64-bit =================    "
echo -e "${GREEN} ไอพีเซิฟ: $IP "
echo -e "${NC} "
echo ""
if [[ ! $CHECKSYSTEM ]]; then
	echo ""
	echo "ใช้งานไม่ได้กับเซิฟเวอร์ระบบปัจจุบัน"
	echo ""
	exit
fi

		clear
echo ""
echo -e "${RED} =============== OS-32 & 64-bit =================    "
echo -e "${RED} #    OS  DEBIAN 8-9-10  OS  UBUNTU 14-16-18    #    "
echo -e "${RED} #         BY : Pirakit Khawpleum               #    "
echo -e "${RED} #    FB : https://m.me/pirakrit.khawplum       #    "
echo -e "${RED} =============== OS-32 & 64-bit =================    "
echo -e "${GREEN} ไอพีเซิฟ: $IP "
echo -e "${NC} "
echo ""
echo -e "${GRAY}แบนและปลดแบนบัญชีผู้ใช้ ${NC} "
echo ""
echo -e "|${GRAY}1${NC}| แบนบัญชีผู้ใช้"
echo -e "|${GRAY}2${NC}| ปลดแบนบัญชีผู้ใช้"
echo ""
read -p "เลือกหัวข้อที่ต้องการใช้งาน : " BandUB

case $BandUB in

	1)

echo ""
read -p "ชื่อบัญชีที่ต้องการแบน : " CLIENT

egrep "^$CLIENT" /etc/passwd >/dev/null
if [ $? -eq 0 ]; then
	echo "V=$CLIENT" >> /usr/local/bin/Ban-Unban
	passwd -l $CLIENT
	clear
	echo ""
	echo "บัญชีชื่อ $CLIENT ได้ถูกแบนเรียบร้อยแล้ว"
	echo ""
	exit
elif [ $? -eq 1 ]; then
	clear
	echo ""
	echo "ไม่มีชื่อบัญชีที่ระบุอยู่ในระบบ"
	echo ""
	read -p "กลับไปที่เมนู (Y or N) : " -e -i Y TOMENU

	if [[ "$TOMENU" = 'Y' ]]; then
		menu
		exit
	elif [[ "$TOMENU" = 'N' ]]; then
		exit
	fi
fi

	;;

	2)

echo ""
read -p "ชื่อบัญชีที่ต้องการปลดแบน : " CLIENT

egrep "^$CLIENT" /etc/passwd >/dev/null
if [ $? -eq 0 ]; then
	sed -i 's/V=$CLIENT/R=$CLIENT/g' /usr/local/bin/Ban-Unban
	passwd -u $CLIENT
	clear
	echo ""
	echo "บัญชีชื่อ $CLIENT ได้ถูกปลดแบนเรียบร้อยแล้ว"
	echo ""
	exit

elif [ $? -eq 1 ]; then
	clear
	echo ""
	echo "ชื่อบัญชีที่ระบุไม่ได้ถูกแบน หรือไม่มีชื่อบัญชีที่ระบุอยู่ในระบบ"
	echo ""
	read -p "กลับไปที่เมนู (Y or N) : " -e -i Y TOMENU

	if [[ "$TOMENU" = 'Y' ]]; then
		menu
		exit
	elif [[ "$TOMENU" = 'N' ]]; then
		exit
	fi
fi

	;;

esac

	;;

	15) # ==================================================================================================================

		clear
echo ""
echo -e "${RED} =============== OS-32 & 64-bit =================    "
echo -e "${RED} #    OS  DEBIAN 8-9-10  OS  UBUNTU 14-16-18    #    "
echo -e "${RED} #         BY : Pirakit Khawpleum               #    "
echo -e "${RED} #    FB : https://m.me/pirakrit.khawplum       #    "
echo -e "${RED} =============== OS-32 & 64-bit =================    "
echo -e "${GREEN} ไอพีเซิฟ: $IP "
echo -e "${NC} "
echo ""
echo -e "${GRAY}ปรับความเร็วอินเตอร์เน็ต ${NC} "
echo ""
echo -e "|${GRAY}1${NC}| เปิดใช้งานการปรับแต่งความเร็วอินเทอร์เน็ต"
echo -e "|${GRAY}2${NC}| ปิดใช้งานการปรับแต่งความเร็วอินเทอร์เน็ต"
echo ""
read -p "เลือกหัวข้อที่ต้องการใช้งาน : " LIMITINTERNET

case $LIMITINTERNET in

	1)

echo ""
echo -e "|${GRAY}1${NC}| Megabyte (Mbps)"
echo -e "|${GRAY}2${NC}| Kilobyte (Kbps)"
echo ""
read -p "กรุณาเลือกหน่วยวัดความเร็วอินเทอร์เน็ต : " -e PERSECOND
case $PERSECOND in
	1)
	PERSECOND=mbit
	;;
	2)
	PERSECOND=kbit
	;;
esac

echo ""
echo ""
echo -e "วิธีการใส่ : เช่นต้องการให้มีความเร็ว 10Mbps ให้ใส่เลข ${GRAY}10${NC}"
echo -e "         หากต้องการให้มีความเร็ว 512Kbps ให้ใส่เลข ${GRAY}512${NC}"
echo ""
read -p "ใส่จำนวนความเร็วการดาวน์โหลด : " -e CHDL
read -p "ใส่จำนวนความเร็วการอัพโหลด : " -e CHUL

DNLD=$CHDL$PERSECOND
UPLD=$CHUL$PERSECOND

TC=/sbin/tc

IF="$(ip ro | awk '$1 == "default" { print $5 }')"
IP="$(ip -o ro get $(ip ro | awk '$1 == "default" { print $3 }') | awk '{print $5}')/32"     # Host IP

U32="$TC filter add dev $IF protocol ip parent 1: prio 1 u32"

    $TC qdisc add dev $IF root handle 1: htb default 30
    $TC class add dev $IF parent 1: classid 1:1 htb rate $DNLD
    $TC class add dev $IF parent 1: classid 1:2 htb rate $UPLD
    $U32 match ip dst $IP flowid 1:1
    $U32 match ip src $IP flowid 1:2
    echo ""
    echo -e "ความเร็วดาวน์โหลด ${GRAY}$CHDL $PERSECOND${NC}"
    echo -e "ความเร็วอัพโหลด ${GRAY}$CHUL $PERSECOND${NC}"
    echo ""
    echo "เปิดใช้งานการปรับแต่งความเร็วอินเทอร์เน็ต"
    echo ""
    exit

	;;

	2)

TC=/sbin/tc
IF="$(ip ro | awk '$1 == "default" { print $5 }')"

    $TC qdisc del dev $IF root
    echo ""
    echo "ปิดใช้งานการปรับแต่งความเร็วอินเทอร์เน็ต"
    echo ""
    exit

	;;

esac

	;;

	16) # ==================================================================================================================

		clear
echo ""
echo -e "${RED} =============== OS-32 & 64-bit =================    "
echo -e "${RED} #    OS  DEBIAN 8-9-10  OS  UBUNTU 14-16-18    #    "
echo -e "${RED} #         BY : Pirakit Khawpleum               #    "
echo -e "${RED} #    FB : https://m.me/pirakrit.khawplum       #    "
echo -e "${RED} =============== OS-32 & 64-bit =================    "
echo -e "${GREEN} ไอพีเซิฟ: $IP "
echo -e "${NC} "
echo ""
echo -e "เปิด-ปิด-รีสตาร์ท การทำงานของระบบ ${GRAY}✿.｡.:* *.:｡✿*ﾟ’ﾟ･✿.｡.:*${NC}"
echo ""
echo -e "|${GRAY}1${NC}| OPENVPN"
echo -e "|${GRAY}2${NC}| SSH DROPBEAR"
echo -e "|${GRAY}3${NC}| SQUID PROXY"
echo ""
read -p "เลือกหัวข้อที่ต้องการใช้งาน : " SERVICE

case $SERVICE in

	1)

	echo ""
	echo -e "	|${GRAY}1${NC}| เปิด"
	echo -e "	|${GRAY}2${NC}| ปิด"
	echo -e "	|${GRAY}3${NC}| รีสตาร์ท"
	echo ""
	read -p "	เลือกหัวข้อที่ต้องการใช้งาน : " SERVICEOPENVPN

	case $SERVICEOPENVPN in

		1)
	service openvpn start
	echo ""
	echo -e "	OpenVPN ${GRAY}STARTED${NC}"
	echo ""
	exit
		;;

		2)
	service openvpn stop
	echo ""
	echo -e "	OpenVPN ${GRAY}STOPPED${NC}"
	echo ""
	exit
		;;

		3)
	service openvpn restart
	echo ""
	echo -e "	OpenVPN ${GRAY}RESTARTED${NC}"
	echo ""
	exit
		;;

	esac

	;;

	2)

	echo ""
	echo -e "	|${GRAY}1${NC}| เปิด"
	echo -e "	|${GRAY}2${NC}| ปิด ${GRAY}หากปิดการทำงานจะไม่สามารถเข้าสู่เทอมินอลได้ ${NC} "
	echo -e "	|${GRAY}3${NC}| รีสตาร์ท"
	echo ""
	read -p "	เลือกหัวข้อที่ต้องการใช้งาน : " SERVICEDROPBEAR

	case $SERVICEDROPBEAR in

		1)

	if [[ -e /etc/default/dropbear ]]; then
		service ssh start
		echo ""
		echo -e "	SSH Dropbear ${GRAY}STARTED${NC}"
		echo ""
		exit
	elif [[ ! -e /etc/default/dropbear ]]; then
		echo ""
		echo "	ยังไม่ได้ติดตั้ง SSH Dropbear"
		echo ""
		exit
	fi
		;;

		2)
	if [[ -e /etc/default/dropbear ]]; then
		service ssh stop
		echo ""
		echo -e "	SSH Dropbear ${GRAY}STOPPED${NC}"
		echo ""
		exit
	elif [[ ! -e /etc/default/dropbear ]]; then
		echo ""
		echo "	ยังไม่ได้ติดตั้ง SSH Dropbear"
		echo ""
		exit
	fi
		;;

		3)
	if [[ -e /etc/default/dropbear ]]; then
		service ssh restart
		echo ""
		echo -e "	SSH Dropbear ${GRAY}RESTARTED${NC}"
		echo ""
		exit
	elif [[ ! -e /etc/default/dropbear ]]; then
		echo ""
		echo "	ยังไม่ได้ติดตั้ง SSH Dropbear"
		echo ""
		exit
	fi
		;;

	esac

	;;

	3)

	echo ""
	echo -e "	|${GRAY}1${NC}| เปิด"
	echo -e "	|${GRAY}2${NC}| ปิด"
	echo -e "	|${GRAY}3${NC}| รีสตาร์ท"
	echo ""
	read -p "	เลือกหัวข้อที่ต้องการใช้งาน : " SERVICEPROXY

	case $SERVICEPROXY in

		1)
	if [[ "$VERSION_ID" = 'VERSION_ID="9"' || "$VERSION_ID" = 'VERSION_ID="16.04"' || "$VERSION_ID" = 'VERSION_ID="18.04"' ]]; then
		if [[ ! -e /etc/squid/squid.conf ]]; then
			echo ""
			echo "	ยังไม่ได้ติดตั้ง Squid Proxy"
			echo ""
			exit
		else
			service squid start
			echo ""
			echo -e "	Squid Proxy ${GRAY}STARTED${NC}"
			echo ""
			exit
		fi
	elif [[ "$VERSION_ID" = 'VERSION_ID="10"' || "$VERSION_ID" = 'VERSION_ID="8"' || "$VERSION_ID" = 'VERSION_ID="14.04"' ]]; then
		if [[ ! -e /etc/squid3/squid.conf ]]; then
			echo ""
			echo "	ยังไม่ได้ติดตั้ง Squid Proxy"
			echo ""
			exit
		else
			service squid3 start
			echo ""
			echo -e "	Squid Proxy ${GRAY}STARTED${NC}"
			echo ""
			exit
		fi
	fi
		;;

		2)
	if [[ "$VERSION_ID" = 'VERSION_ID="9"' || "$VERSION_ID" = 'VERSION_ID="16.04"' || "$VERSION_ID" = 'VERSION_ID="18.04"' ]]; then
		if [[ ! -e /etc/squid/squid.conf ]]; then
			echo ""
			echo "	ยังไม่ได้ติดตั้ง Squid Proxy"
			echo ""
			exit
		else
			service squid stop
			echo ""
			echo -e "	Squid Proxy ${GRAY}STOPPED${NC}"
			echo ""
			exit
		fi
	elif [[ "$VERSION_ID" = 'VERSION_ID="10"' || "$VERSION_ID" = 'VERSION_ID="8"' || "$VERSION_ID" = 'VERSION_ID="14.04"' ]]; then
		if [[ ! -e /etc/squid3/squid.conf ]]; then
			echo ""
			echo "	ยังไม่ได้ติดตั้ง Squid Proxy"
			echo ""
			exit
		else
			service squid3 stop
			echo ""
			echo -e "	Squid Proxy ${GRAY}STOPPED${NC}"
			echo ""
			exit
		fi
	fi
		;;

		3)
	if [[ "$VERSION_ID" = 'VERSION_ID="9"' || "$VERSION_ID" = 'VERSION_ID="16.04"' || "$VERSION_ID" = 'VERSION_ID="17.04"' ]]; then
		if [[ ! -e /etc/squid/squid.conf ]]; then
			echo ""
			echo "	ยังไม่ได้ติดตั้ง Squid Proxy"
			echo ""
			exit
		else
			service squid restart
			echo ""
			echo -e "	Squid Proxy ${GRAY}RESTARTED${NC}"
			echo ""
			exit
		fi
	elif [[ "$VERSION_ID" = 'VERSION_ID="10"' || "$VERSION_ID" = 'VERSION_ID="8"' || "$VERSION_ID" = 'VERSION_ID="14.04"' ]]; then
		if [[ ! -e /etc/squid3/squid.conf ]]; then
			echo ""
			echo "	ยังไม่ได้ติดตั้ง Squid Proxy"
			echo ""
			exit
		else
			service squid3 restart
			echo ""
			echo -e "	Squid Proxy ${GRAY}RESTARTED${NC}"
			echo ""
			exit
		fi
	fi
		;;

	esac

	;;

esac

	;;

	17) # ==================================================================================================================

clear
echo ""
echo -e "${RED} =============== OS-32 & 64-bit =================    "
echo -e "${RED} #    OS  DEBIAN 8-9-10  OS  UBUNTU 14-16-18    #    "
echo -e "${RED} #         BY : Pirakit Khawpleum               #    "
echo -e "${RED} #    FB : https://m.me/pirakrit.khawplum       #    "
echo -e "${RED} =============== OS-32 & 64-bit =================    "
echo -e "${GREEN} ไอพีเซิฟ: $IP "
echo -e "${NC} "
echo ""
echo -e "|${GRAY}1${NC}| OPENVPN ไฟล์ต้นแบบการสร้างคอนฟิก"
echo -e "|${GRAY}2${NC}| OPENVPN ไฟล์ข้อมูลเซิฟเวอร์"
echo -e "|${GRAY}3${NC}| SQUID PROXY ไฟล์รายละเอียดของพร็อกซี่"
echo -e "|${GRAY}4${NC}| MENU ไฟล์สคริปท์ของเมนู"
echo -e "|${GRAY}5${NC}| Banner HTTP INJECTOR"
echo ""
echo ""
read -p "เลือกหัวข้อที่ต้องการใช้งาน : " EDIT

case $EDIT in

	1)
nano /etc/openvpn/client-common.txt
exit
	;;
	2)
nano /etc/openvpn/server.conf
exit
	;;
	3)
if [[ "$VERSION_ID" = 'VERSION_ID="9"' || "$VERSION_ID" = 'VERSION_ID="16.04"' || "$VERSION_ID" = 'VERSION_ID="17.04"' ]]; then
	nano /etc/squid/squid.conf
	exit
elif [[ "$VERSION_ID" = 'VERSION_ID="10"' || "$VERSION_ID" = 'VERSION_ID="8"' || "$VERSION_ID" = 'VERSION_ID="14.04"' ]]; then
	nano /etc/squid3/squid.conf
	exit
fi
	;;
	4)
nano /usr/local/bin/m
exit
	;;
	5)	
nano /etc/bannerssh
exit
	;;

esac

	;;
	
	18) # ==================================================================================================================
	
				# This option could be documented a bit better and maybe even be simplified
			# ...but what can I say, I want some sleep too
			number_of_clients=$(tail -n +2 /etc/openvpn/server/easy-rsa/pki/index.txt | grep -c "^V")
			if [[ "$number_of_clients" = 0 ]]; then
				echo
				echo " >>>clients<<< ไม่มีอยู่แล้ว!"
				exit
			fi
			echo
			echo "เลือก >>>clients<<<ที่จะเพิกถอน:"
			tail -n +2 /etc/openvpn/server/easy-rsa/pki/index.txt | grep "^V" | cut -d '=' -f 2 | nl -s ') '
			read -p "Client: " client_number
			until [[ "$client_number" =~ ^[0-9]+$ && "$client_number" -le "$number_of_clients" ]]; do
				echo "$client_number: invalid selection."
				read -p "Client: " client_number
			done
			client=$(tail -n +2 /etc/openvpn/server/easy-rsa/pki/index.txt | grep "^V" | cut -d '=' -f 2 | sed -n "$client_number"p)
			echo
			read -p "ยืนยันการเพิกถอน $client ? [y/N]: " revoke
			until [[ "$revoke" =~ ^[yYnN]*$ ]]; do
				echo "$revoke: invalid selection."
				read -p "ยืนยัน $client เพิกถอน? [y/N]: " revoke
			done
			if [[ "$revoke" =~ ^[yY]$ ]]; then
				cd /etc/openvpn/server/easy-rsa/
				./easyrsa --batch revoke "$client"
				EASYRSA_CRL_DAYS=3650 ./easyrsa gen-crl
				rm -f /etc/openvpn/server/crl.pem
				cp /etc/openvpn/server/easy-rsa/pki/crl.pem /etc/openvpn/server/crl.pem
				# CRL is read with each client connection, when OpenVPN is dropped to nobody
				chown nobody:"$group_name" /etc/openvpn/server/crl.pem
				echo
				echo "$client เพิกถอนแลัว!"
			else
				echo
				echo "$client การเพิกถอนถูกยกเลิก!"
			fi
			exit
		;;

	00) # ==================================================================================================================

cd /usr/local/bin
wget -q -O m "https://raw.githubusercontent.com/MyGatherBk/MyAuto/master/menu.sh"
chmod +x /usr/local/bin/m
m

	;;



esac
