# Automated Minecraft Server Setup on AWS EC2

This project automatically provisions an EC2 instance and configures it to run a Minecraft Server.

## Requirements

Here's a list of requirements. This project uses terraform and bash scripts. 

- Amazon Web Services (AWS) account
- AWS Command Line Interface >= 2.11.25
- bash >= 3.2
- Terraform >= v1.4.6

Additionally, you need to have your security credentials locally configured in the file ``~/.aws/credentials``. These can be found in your IAM console. 

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
4. Manage the ``start_server.service`` using the ``systemctl`` command. The service will automatically startup the server when the instance launches.
5. You can modify the ``main.tf`` and ``start_server.service`` to change what EC2 instance is used and what parameters are passed to the minecraft server, respectively. 

## Pipeline Overview

![plot](diagram.png)




## Sources

https://github.com/KopiCloud/terraform-aws-ubuntu-ec2-instance generating key pair and saving locally using Terraform (key_pair_main.tf).

https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/instance specifying Ubuntu AMI (main.tf). 

https://developer.hashicorp.com/terraform/tutorials/aws-get-started/aws-outputs using terraform outputs in scripts (run_setup.sh). 

https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/security_group configuring security groups (main.tf). 

https://gist.github.com/pditommaso/dfe085101259e43f8ba761cd4dcf2d54 waiting for ssh connection (wait_for_instance.sh)

https://docs.aws.amazon.com/cli/latest/reference/ec2/wait/instance-status-ok.html waiting for instance to have correct status (wait_for_instance.sh)

