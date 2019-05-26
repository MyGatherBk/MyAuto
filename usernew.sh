#!/bin/bash
#script by pirakit khawpleum

if [[ $CHECKSYSTEM ]]; then
	echo ""
	read -p "ชื่อบัญชีที่ต้องการสร้าง : " -e CLIENT

	if [ $? -eq 0 ]; then
		read -p "รหัสผ่าน : " -e PASSWORD
		echo ""
		echo -e "     ${GRAY}ระบุตัวเลข 30 จะทำให้บัญชีที่สร้างใช้งานไม่ได้ในอีก 30 วัน${NC}"
		read -p "กำหนดวันหมดอายุ : " -e TimeActive

		PROXY=$(grep '^http_port ' /etc/squid/squid.conf | cut -d " " -f 2)
		PROXY=$(grep '^http_port ' /etc/squid3/squid.conf | cut -d " " -f 2)
		useradd -e `date -d "$TimeActive days" +"%Y-%m-%d"` -s /bin/false -M $CLIENT
		EXP="$(chage -l $CLIENT | grep "Account expires" | awk -F": " '{print $2}')"
		echo -e "$PASSWORD\n$PASSWORD\n"|passwd $CLIENT &> /dev/null

		clear
	echo ""
	echo "~¤~ ๏[-ิ_•ิ]๏ ~¤~ Admin MyGatherBK ~¤~ ๏[-ิ_•ิ]๏ ~¤~"
	echo ""
		echo "ชื่อบัญชี : $CLIENT"
		echo "รหัสผ่าน : $PASSWORD"
		echo "หมดอายุในวันที่ : $EXP"
		echo ""
		echo "IP : $IP"
		echo "Port : 22,443"
		echo "Proxy Port : $PROXY"
		exit
	else
		echo ""
		echo "ชื่อบัญชีที่ระบุอยู่ในระบบแล้ว"
		echo ""
		read -p "กลับไปที่เมนู (Y or N) : " -e -i Y TOMENU

		if [[ "$TOMENU" = 'Y' ]]; then
			menu
			exit
		elif [[ "$TOMENU" = 'N' ]]; then
			exit
		fi
	fi

else

	echo ""
	read -p "ชื่อบัญชีที่ต้องการสร้าง : " -e CLIENT

	if [[ -e /etc/openvpn/easy-rsa/pki/private/$CLIENT.key ]]; then
		echo ""
		echo "ชื่อบัญชีที่ระบุอยู่ในระบบแล้ว"
		echo ""
		read -p "กลับไปที่เมนู (Y or N) : " -e -i Y TOMENU

		if [[ "$TOMENU" = 'Y' ]]; then
			menu
			exit
		elif [[ "$TOMENU" = 'N' ]]; then
			exit
		fi
	fi

	echo ""
	echo -e "     ${GRAY}ระบุตัวเลข 30 จะทำให้บัญชีที่สร้างใช้งานไม่ได้ในอีก 30 วัน${NC}"
	read -p "กำหนดวันหมดอายุ : " -e TimeActive

	newclient () {
		cp /etc/openvpn/client-common.txt ~/$1.ovpn
		echo "<ca>" >> ~/$1.ovpn
		cat /etc/openvpn/easy-rsa/pki/ca.crt >> ~/$1.ovpn
		echo "</ca>" >> ~/$1.ovpn
		echo "<cert>" >> ~/$1.ovpn
		cat /etc/openvpn/easy-rsa/pki/issued/$1.crt >> ~/$1.ovpn
		echo "</cert>" >> ~/$1.ovpn
		echo "<key>" >> ~/$1.ovpn
		cat /etc/openvpn/easy-rsa/pki/private/$1.key >> ~/$1.ovpn
		echo "</key>" >> ~/$1.ovpn
		echo "<tls-auth>" >> ~/$1.ovpn
		cat /etc/openvpn/ta.key >> ~/$1.ovpn
		echo "</tls-auth>" >> ~/$1.ovpn
	}

	RANDOMFOLDER=$(cat /dev/urandom | tr -dc 'a-zA-Z' | fold -w 4 | head -n 1)
	mkdir /home/vps/public_html/$RANDOMFOLDER
	cd /etc/openvpn/easy-rsa/
	./easyrsa build-client-full $CLIENT nopass
	newclient "$CLIENT"
	cp /root/$CLIENT.ovpn /home/vps/public_html/$RANDOMFOLDER/$CLIENT.ovpn
	rm -f /root/$CLIENT.ovpn
	useradd -e `date -d "$TimeActive days" +"%Y-%m-%d"` -s /bin/false -M $CLIENT
	EXP="$(chage -l $CLIENT | grep "Account expires" | awk -F": " '{print $2}')"
	echo -e "$CLIENT\n$CLIENT\n"|passwd $CLIENT &> /dev/null

	clear
	echo ""
	echo "~¤~ ๏[-ิ_•ิ]๏ ~¤~ Admin MyGatherBK ~¤~ ๏[-ิ_•ิ]๏ ~¤~"
	echo ""
	echo "ชื่อบัญชี : $CLIENT"
	echo "หมดอายุในวันที่ : $EXP"
	echo ""
	echo "ดาวน์โหลดคอนฟิก : http://$IP:85/$RANDOMFOLDER/$CLIENT.ovpn"
	echo ""
	exit

fi

	;;
