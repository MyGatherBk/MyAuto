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

sed -i '28d' /etc/openvpn/server/server.conf
sed -i '28d' /etc/openvpn/server/server.conf
sed -i '28d' /etc/openvpn/server/server.conf
sed -i '20d' /etc/openvpn/server/client-common.txt
echo "client-to-client" >> /etc/openvpn/server/server.conf
echo ""
echo "ปรับเปลี่ยนระบบของเซิฟเวอร์เป็นรูปแบบที่ 1 เรียบร้อย"
echo ""
service openvpn restart

	;;

	2)

sed -i '28d' /etc/openvpn/server/server.conf
sed -i '28d' /etc/openvpn/server/server.conf
sed -i '28d' /etc/openvpn/server/server.conf
sed -i '20d' /etc/openvpn/server/client-common.txt
if [[ "$VERSION_ID" = 'VERSION_ID="7"' ]]; then
	echo "plugin /usr/lib/openvpn/openvpn-auth-pam.so /etc/pam.d/login" >> /etc/openvpn/server/server.conf
	echo "client-cert-not-required" >>  /etc/openvpn/server/server.conf
	echo "username-as-common-name" >>  /etc/openvpn/server/server.conf
else
	echo "plugin /usr/lib/openvpn/openvpn-plugin-auth-pam.so /etc/pam.d/login" >> /etc/openvpn/server/server.conf
	echo "client-cert-not-required" >> /etc/openvpn/server/server.conf
	echo "username-as-common-name" >>  /etc/openvpn/server/server.conf
fi
echo "auth-user-pass" >> /etc/openvpn/server/client-common.txt
echo ""
echo "ปรับเปลี่ยนระบบของเซิฟเวอร์เป็นรูปแบบที่ 2 เรียบร้อย"
echo ""
service openvpn restart

	;;

	3)

sed -i '28d' /etc/openvpn/server/server.conf
sed -i '28d' /etc/openvpn/server/server.conf
sed -i '28d' /etc/openvpn/server/server.conf
sed -i '20d' /etc/openvpn/server/client-common.txt
echo "duplicate-cn" >> /etc/openvpn/server.conf
echo ""
echo "ปรับเปลี่ยนระบบของเซิฟเวอร์เป็นรูปแบบที่ 3 เรียบร้อย"
echo ""
service openvpn restart

	;;

esac

	;;
