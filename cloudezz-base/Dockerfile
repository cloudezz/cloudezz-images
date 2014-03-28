FROM ubuntu:12.04

MAINTAINER bbytes  "info@beyondbytes.co.in"

# Set locale
RUN locale-gen --no-purge en_US.UTF-8
ENV LC_ALL en_US.UTF-8

ENV DEBIAN_FRONTEND noninteractive

#create cloudezz user	
RUN useradd cloudezz -s /bin/bash -m -g sudo -G sudo >/dev/null 2>/dev/null	

# make sure the package repository is up to date and update ubuntu
RUN echo "deb http://archive.ubuntu.com/ubuntu precise main universe" > /etc/apt/sources.list
RUN sed 's/main$/main universe/' -i /etc/apt/sources.list

RUN apt-get update
RUN apt-get -y upgrade
	
# add sshd service and add the sshkey 
RUN apt-get install -y openssh-server

RUN mkdir /var/run/sshd

RUN mkdir /root/.ssh
RUN chmod 700 /root/.ssh
RUN /usr/bin/ssh-keygen -q -t rsa -N "" -f /root/.ssh/id_rsa
RUN cat /root/.ssh/id_rsa.pub >> /root/.ssh/authorized_keys
# Ensure correct permissions for root/.ssh and /etc/ssh/*
RUN chmod 600 /root/.ssh/*
RUN chmod 600 /etc/ssh/*
RUN chown -Rf root:root /root/.ssh
RUN chown -Rf root:root /etc/ssh/*


# NOTE: expose ssh to connect 
EXPOSE 22

#install fail2ban package to avoid dos attach thru ssh 
RUN apt-get install -y fail2ban

ADD jail.local /etc/fail2ban/jail.local

#install shell-in-a-box
RUN mkdir -p /tmp/cloudezz/shellinabox
RUN wget -P /tmp/cloudezz/shellinabox http://archive.ubuntu.com/ubuntu/pool/universe/s/shellinabox/shellinabox_2.14-1_amd64.deb
RUN chmod +x /tmp/cloudezz/shellinabox/shellinabox_2.14-1_amd64.deb
RUN cd /tmp/cloudezz/shellinabox ; dpkg -i shellinabox_2.14-1_amd64.deb
RUN rm -f /tmp/cloudezz/shellinabox/shellinabox_2.14-1_amd64.deb
RUN service shellinabox stop
ADD shellinabox /etc/default/shellinabox

# 'shell in a box' web access port 
EXPOSE 4022

# Install some packages we need
RUN apt-get install -y rinetd
RUN apt-get install -y joe
RUN apt-get install -y git
RUN apt-get install -y unzip

# Install serf - http://www.serfdom.io/ v0.5.0
ADD https://dl.bintray.com/mitchellh/serf/0.5.0_linux_amd64.zip serf.zip
RUN unzip serf.zip
RUN rm serf.zip
RUN mv serf /usr/bin/

# 'serf agent listening port' 
EXPOSE 7946

# install supervisor (which has no package on 12.04) to manage our processes
# the supervisor config file is more likely to change and is therefore added as a later step
RUN apt-get install -y supervisor 
RUN apt-get clean
RUN mkdir -p /var/log/supervisor
# create directory for child images to store configuration in
RUN  mkdir -p /etc/supervisor/conf.d

# add supervisor conf files that will start when supervisord starts
ADD supervisor.conf /etc/supervisor.conf
ADD supervisor.conf /etc/supervisor/supervisor.conf
ADD sshd.conf /etc/supervisor/conf.d/sshd.conf
ADD rinetd.conf /etc/supervisor/conf.d/rinetd.conf
ADD serf.conf /etc/supervisor/conf.d/serf.conf


#Install PIP
RUN apt-get install -y python python-dev python-setuptools
RUN easy_install pip
#Install fabric
RUN pip install requests
RUN pip install fabric


# NOTE: Create base folder
RUN mkdir -p /cloudezz

RUN mkdir -p /opt/cloudezz-config
ADD rinetd.sh /opt/cloudezz-config/rinetd.sh
RUN chmod +x /opt/cloudezz-config/rinetd.sh

ADD start-serf.sh /opt/cloudezz-config/start-serf.sh
RUN chmod +x /opt/cloudezz-config/start-serf.sh


ADD ssh-key-init.sh /opt/cloudezz-config/ssh-key-init.sh
RUN chmod +x /opt/cloudezz-config/ssh-key-init.sh

ADD start.sh /opt/cloudezz-config/start.sh
RUN chmod +x /opt/cloudezz-config/start.sh




CMD cd /opt/cloudezz-config && ./start.sh


