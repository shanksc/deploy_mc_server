# Automated Minecraft Server Setup on AWS EC2

This project is automatically provisions an EC2 instance and configures it to run a Minecraft Server.

## Requirements

Here's a list of requirements. This project uses terraform and bash scripts. 

- Amazon Web Services (AWS) account
- AWS Command Line Interface >= 2.11.25
- bash >= 3.2
- Terraform >= v1.4.6

Additionally, you need to have your security credentials locally configured in the file ~/.aws/credentials. These can be found in your IAM console. 

```
[default]
aws_access_key_id={AWS_ACCESS_KEY_ID}
aws_secret_access_key={AWS_SECRET_ACCESS_KEY}
aws_session_token={AWS_SESSION_TOKEN}
```


## Setup
1. Download this repository.
2. Run ``bash run_setup.sh``. This runs provisions the EC2 instance and enables the service that runs the server. 
3. Look at the contents of ``ip_addr.txt`` to get the public ipv4. This is the ip address for connecting to the server in Minecraft. 



