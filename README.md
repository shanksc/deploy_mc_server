1. Begin with AWS credential setup from last lab, installing terraform and other dependencies



# Minecraft Server Setup on AWS EC2
This is a brief tutorial for setting up the Java version of Minecraft on an EC2 instance through Amazon Web Services. The prerequisite for this is that you already have an AWS account and access to the java version of Minecraft.

## AWS Setup
1.  From the EC2 dashboard click Launch Instance.
2. Name your server and then select Ubuntu Server. This should be available in the quick start selection, otherwise search for it and ensure that it's the Ubuntu Server 22.04 LTS, 64-bit x86 architecture. 
3. Scroll down and to the Instance Type selection. For a small Minecraft Server t2.small should be more than sufficient. 
4. Scroll down and create a new key pair and name it to your liking. Use the RSA option which is default anyways. Make sure you keep this in an accessible location for later. 
5. Next go to Network Settings. Click on Edit in the top right of this section. Scroll down and add a new security group rule. Set the port range to 25565. This is the default port for Java Minecraft servers. Let the CIDR be 0.0.0.0/0. 
6. There's nothing left to configure. Scroll down and launch the instance. 
7. Navigate back to the EC2 dashboard. Once the server has indicated that it's running click on the instance ID and then click connect in the upper right. Connect to the server by copying the given SSH command. Make sure your key file (.pem) is available for the command and that the permissions are correct (chmod 400). 

## Minecraft Setup
1. Once logged in run the following command to install the correct version of Java, `` sudo apt install openjdk-17-jre ``.
2. Create a new directory with ``sudo mkdir /usr/local/minecraft `` and ``cd`` into it. 
3. Download minecraft with ``sudo wget https://piston-data.mojang.com/v1/objects/8f3112a1049751cc472ec13e397eade5336ca7ae/server.jar``.
4. Next we're going to automate the server running on startup. We're using systemctl to accomplish this. Open a file with ``sudo vim /etc/systemd/system/start_server.service``
5. Copy this into the file,
```
[Unit]
Description=Startup Minecraft server
After=network-online.target

[Service]
Type=simple
WorkingDirectory=/usr/local/minecraft/
ExecStart=/usr/bin/java -Xmx1024M -Xms1024M -jar server.jar nogui

[Install]
WantedBy=multi-user.target
```
6. Save this and and run ``sudo chmod 664 /etc/systemd/system/start_server.service``
7.  Run ``sudo systemctl enable start_server.service``
8.  cd back into ``/usr/local/minecraft/`` and then create a file called ``eula.txt``. Just write one line ``eula=true`` and save. This ensures that when we restart the instance for the first time it won't fail since launching the Minecraft server requires we agreed to the end user license agreement. 
9. Now run ``sudo ufw allow 25565/tcp`` so we can accept connections outside of our local network.
10. Restart your instance. One option is running ``sudo reboot`` and then reconnecting. 
11.  Join your server with the Public IPv4 listed in your specific instance. 
12.  End the AWS EC2 instance in the dashboard by clicking instance state in the upper right and then stop. 



