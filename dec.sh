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


sed -i '28d' /etc/openvpn/server/server.conf
sed -i '28d' /etc/openvpn/server/server.conf
sed -i '28d' /etc/openvpn/server/server.conf
sed -i '20d' /etc/openvpn/server/client-common.txt
echo "duplicate-cn" >> /etc/openvpn/server.conf
echo ""
echo "ปรับเปลี่ยนระบบของเซิฟเวอร์เป็นรูปแบบที่ 1 เรียบร้อย"
echo ""
service openvpn restart
exit
