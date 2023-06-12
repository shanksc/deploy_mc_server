#!/bin/bash
#initalize terraform any apply
terraform init
terraform apply

#save ip addr
IP="$(terraform output -raw instance_ip_addr)"
echo "$IP" > ip_addr.txt

#save DNS to pass as arg
DNS="$(terraform output -raw instance_public_dns)"

#make readable
chmod 400 ubuntu-key-pair.pem

#get instance id to pass as arg
INSTANCE_ID="$(terraform output -raw instance_id)"

#wait for instance to be ready for ssh connection
bash wait_for_instance.sh $DNS $INSTANCE_ID 5

#setup minecraft on server, enable service
bash setup_minecraft.sh $DNS

#wait again
bash wait_for_instance.sh $DNS $INSTANCE_ID 20
echo "########## setup complete connect to $IP ##########"
