#!/bin/bash
# Script เพิ่มบัญชีผู้ใช้ OpenVPN
# Created by MyGatherBK

echo
			echo "Provide a name for the client:"
			read -p "Name: " unsanitized_client
			client=$(sed 's/[^0123456789abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ_-]/_/g' <<< "$unsanitized_client")
			while [[ -z "$client" || -e /etc/openvpn/server/easy-rsa/pki/issued/"$client".crt ]]; do
				echo "$client: invalid name."
				read -p "Name: " unsanitized_client
				client=$(sed 's/[^0123456789abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ_-]/_/g' <<< "$unsanitized_client")
			done
			cd /etc/openvpn/server/easy-rsa/
			EASYRSA_CERT_EXPIRE=3650 ./easyrsa build-client-full "$client" nopass
			# Generates the custom client.ovpn
			
			echo
			echo "$client added. Configuration available in:" ~/"$client.ovpn"
			exit
