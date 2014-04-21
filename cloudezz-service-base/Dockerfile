FROM ubuntu:12.04

MAINTAINER bbytes  "info@beyondbytes.co.in"

# Set locale
RUN locale-gen --no-purge en_US.UTF-8
ENV LC_ALL en_US.UTF-8

ENV DEBIAN_FRONTEND noninteractive

#create cloudezz user	
RUN useradd cloudezz -s /bin/bash -m -g sudo -G sudo >/dev/null 2>/dev/null	

# NOTE: Create base folder
RUN mkdir -p /cloudezz
RUN mkdir -p /opt/cloudezz-config
ADD cloudezz-config /opt/cloudezz-config
RUN chmod +x -R /opt/cloudezz-config/

# make sure the package repository is up to date and update ubuntu
RUN echo "deb http://archive.ubuntu.com/ubuntu precise main universe" > /etc/apt/sources.list
RUN sed 's/main$/main universe/' -i /etc/apt/sources.list

RUN apt-get -y upgrade
RUN apt-get update

	
#  Install some packages we need and add sshd service and add the sshkey 
RUN apt-get install -y python-setuptools openssh-server joe git unzip fail2ban supervisor 

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


#install fail2ban package to avoid dos attach thru ssh 
ADD cloudezz-config/jail.local /etc/fail2ban/jail.local

#install shell-in-a-box
RUN mkdir -p /tmp/cloudezz/shellinabox
RUN wget -P /tmp/cloudezz/shellinabox http://archive.ubuntu.com/ubuntu/pool/universe/s/shellinabox/shellinabox_2.14-1_amd64.deb
RUN chmod +x /tmp/cloudezz/shellinabox/shellinabox_2.14-1_amd64.deb
RUN cd /tmp/cloudezz/shellinabox ; dpkg -i shellinabox_2.14-1_amd64.deb
RUN rm -f /tmp/cloudezz/shellinabox/shellinabox_2.14-1_amd64.deb
RUN service shellinabox stop
ADD cloudezz-config/shellinabox /etc/default/shellinabox


# Install serf - http://www.serfdom.io/ v0.5.0
ADD https://dl.bintray.com/mitchellh/serf/0.5.0_linux_amd64.zip serf.zip
RUN unzip serf.zip
RUN rm serf.zip
RUN mv serf /usr/bin/

# NOTE: expose ssh to connect ,'shell in a box' web access port  ,'serf agent listening port' 
EXPOSE 22 4022 7946

# the supervisor config file is more likely to change and is therefore added as a later step
RUN mkdir -p /var/log/supervisor
# create directory for child images to store configuration in
RUN  mkdir -p /etc/supervisor/conf.d

# add supervisor conf files that will start when supervisord starts
ADD supervisor/supervisor.conf /etc/supervisor.conf
ADD supervisor/supervisor.conf /etc/supervisor/supervisor.conf
ADD supervisor/conf.d /etc/supervisor/conf.d


#Install PIP
RUN easy_install pip
#Install fabric
RUN pip install requests 
RUN apt-get install -y fabric


CMD cd /opt/cloudezz-config && ./start.sh


