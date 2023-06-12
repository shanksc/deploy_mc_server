#!/bin/bash
terraform init
terraform apply
IP="$(terraform output -raw instance_ip_addr)"
echo "$IP\n" > ip_addr.txt
DNS="$(terraform output -raw instance_public_dns)"
chmod 400 linux-key-pair.pem
bash setup_minecraft.sh $DNS
echo "########## setup complete connect to $IP ##########"
