#!/bin/bash
terraform init
terraform apply
IP="$(terraform output -raw instance_ip_addr)"
echo "$IP" > ip_addr.txt
DNS="$(terraform output -raw instance_public_dns)"
chmod 400 ubuntu-key-pair.pem
bash setup_minecraft.sh $DNS
echo "########## setup complete connect to $IP ##########"
