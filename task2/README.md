# TASK 1
Prepare Dockerfile that will build basic image containing tools like ssh,terraform,awscli and script allowing us to connect to ec2 instance via ssh tunnel created with aws ssm.
## Usage:
### 1. Ensure latest SSM Agent on Target Instance (AWS EC-2)
```sh
$ yum install -y https://s3.amazonaws.com/ec2-downloads-windows/SSMAgent/latest/linux_amd64/amazon-ssm-agent.rpm 
$ service amazon-ssm-agent restart
```
### 2. Clone this repository and build docker image
run docker-build . and docker run -it <docker_build_id> bash

### 5. Open SSH Connection
 Ensure AWS CLI environemnt variables are set properly (aws configure)
  ssh <INSTACEC_USER>@<INSTANCE_ID> example:

 ```sh
 ssh ec2-user@i-23i2djs1293a
 ```

Example output:

```sh
root@e3b55d69a6a1:~/.ssh# ssh ec2-user@i-062daea59d18215ad
Add public key /root/.ssh/id_rsa.pub to instance i-062daea59d18215ad for 60 seconds
Start ssm session to instance i-062daea59d1xxx215ad
Warning: Permanently added 'i-062daea59dw8xxx215ad' (ECDSA) to the list of known hosts.
Last login: Wed Jun  3 11:18:17 2020 from localhost

       __|  __|_  )
       _|  (     /   Amazon Linux AMI
      ___|\___|___|

https://aws.amazon.com/amazon-linux-ami/2018.03-release-notes/
No packages needed for security; 7 packages available
Run "sudo yum update" to apply all updates.
```



