# Pull base image.
FROM ubuntu:latest
MAINTAINER jakub@kadzielawa.pl
ENV TERRAFORM_VERSION=0.12.25

# install required packages
RUN apt-get update && apt-get install -y \
  unzip \
  curl \
  wget \
  vim \
  ssh

#install terraform and verifying if it's ok
RUN wget https://releases.hashicorp.com/terraform/${TERRAFORM_VERSION}/terraform_${TERRAFORM_VERSION}_linux_amd64.zip && \
    unzip terraform_${TERRAFORM_VERSION}_linux_amd64.zip -d /usr/bin && \
    rm -rf /tmp/* && \
    rm -rf /var/cache/apk/* && \
    rm -rf /var/tmp/*
RUN terraform --version 

#prepare script for tunneling
RUN echo y | ssh-keygen -q -t rsa -N '' -f ~/.ssh/id_rsa
COPY aws_ssm_ec2_tunneling.sh /root/.ssh
RUN echo 'host i-* mi-* \n\
	IdentityFile ~/.ssh/id_rsa \n\
	ProxyCommand ~/.ssh/aws_ssm_ec2_tunneling.sh %h %r %p ~/.ssh/id_rsa.pub \n\
	StrictHostKeyChecking no' > ~/.ssh/config
	
#install python
RUN apt-get install -y python3-pip
RUN ln -s /usr/bin/python3 python
RUN pip3 install --upgrade pip
RUN python3 -V
RUN pip --version
#install awscli
RUN pip install awscli --upgrade --user

# add aws cli location to path
ENV PATH=~/.local/bin:$PATH

#download session manager plugin
RUN curl "https://s3.amazonaws.com/session-manager-downloads/plugin/latest/ubuntu_64bit/session-manager-plugin.deb" -o "session-manager-plugin.deb" && \
    dpkg -i session-manager-plugin.deb && \
    rm session-manager-plugin.deb

RUN mkdir ~/.aws && touch ~/.aws/credentials
