#!/bin/bash
echo "########## connecting to ubuntu@$1 and setting up minecraft directory ###########"
ssh -i  ubuntu-key-pair.pem  ubuntu@$1 '
    sudo apt -y update
    sudo apt -y install openjdk-17-jre-headless
    sudo mkdir /usr/local/minecraft/
    sudo wget -O /usr/local/minecraft/server.jar https://piston-data.mojang.com/v1/objects/15c777e2cfe0556eef19aab534b186c0c6f277e1/server.jar
    sudo chown ubuntu /usr/local/minecraft/
    #create eula file in advance
    echo 'eula=true' > /usr/local/minecraft/eula.txt
    sudo chown ubuntu /etc/systemd/system/'
echo "########## minecraft directory setup complete ##########"

echo "########## setting up service for automatic server startup ##########"
scp -i ubuntu-key-pair.pem  start_server.service ubuntu@$1:/etc/systemd/system/
ssh -i ubuntu-key-pair.pem ubuntu@$1 'sudo chmod 664 /etc/systemd/system/start_server.service
    sudo systemctl enable start_server.service
    #precautionary incase ubuntu firewall blocks mc server port 
    sudo ufw allow 25565
    sudo reboot now'
echo "restarting server"

