#!/bin/bash
#script by pirakit khawpleum

clear
	echo ""
	echo "~¤~ ๏[-ิ_•ิ]๏ ~¤~ Admin MyGatherBK ~¤~ ๏[-ิ_•ิ]๏ ~¤~"
	echo ""
echo ""
echo "ลำดับ   ชื่อบัญชีผู้ใช้        สถานะ      วันหมดอายุ"
echo ""
C=1
ON=0
OFF=0
while read ONOFF
do
	CLIENTOFFLINE=$(echo -e "${GRAY}OFFLINE${NC}")
	CLIENTONLINE=$(echo -e "${GREEN}ONLINE${NC}")
	ACCOUNT="$(echo $ONOFF | cut -d: -f1)"
	ID="$(echo $ONOFF | grep -v nobody | cut -d: -f3)"
	EXP="$(chage -l $ACCOUNT | grep "Account expires" | awk -F": " '{print $2}')"
	ONLINE="$(cat /etc/openvpn/openvpn-status.log | grep -Eom 1 $ACCOUNT | grep -Eom 1 $ACCOUNT)"
	if [[ $ID -ge 1000 ]]; then
		if [[ -z $ONLINE ]]; then
			printf "%-6s %-15s %-20s %-3s\n" "$C" "$ACCOUNT" "$CLIENTOFFLINE" "$EXP"
			OFF=$((OFF+1))
		else
			printf "%-6s %-15s %-20s %-3s\n" "$C" "$ACCOUNT" "$CLIENTONLINE" "$EXP"
			ON=$((ON+1))
		fi
			C=$((C+1))
        fi
done < /etc/passwd
TOTAL="$(awk -F: '$3 >= '1000' && $1 != "nobody" {print $1}' /etc/passwd | wc -l)"
echo ""
echo ""
echo -e "กำลังเชื่อมต่อ ${GREEN}$ON${NC}  |  ไม่ได้เชื่อมต่อ ${GRAY}$OFF${NC}  |  บัญชีทั้งหมด $TOTAL"
echo ""
exit

	;;