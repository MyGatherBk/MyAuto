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
echo -e "|${GRAY}1${NC}| 1 ไฟล์เชื่อมต่อได้ไม่จำกัดเครื่อง"
echo ""
read -p "เลือกหัวข้อที่ต้องการใช้งาน : " CHANGESYSTEMSERVER

case $CHANGESYSTEMSERVER in

	1)

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

