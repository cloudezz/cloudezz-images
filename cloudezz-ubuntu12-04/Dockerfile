FROM ubuntu:12.04

MAINTAINER bbytes  "info@beyondbytes.co.in"

#create cloudezz user	
RUN useradd cloudezz -s /bin/bash -m -g sudo -G sudo >/dev/null 2>/dev/null	

# make sure the package repository is up to date and update ubuntu
RUN echo "deb http://archive.ubuntu.com/ubuntu precise main universe" > /etc/apt/sources.list
RUN sed 's/main$/main universe/' -i /etc/apt/sources.list

RUN apt-get update
RUN apt-get -y upgrade
	
# add sshd service and add the sshkey 
RUN apt-get install -y openssh-server

RUN mkdir /root/.ssh
RUN mkdir /var/run/sshd

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
RUN service shellinabox stop
ADD shellinabox /etc/default/shellinabox

# 'shell in a box' web access port 
EXPOSE 4022


# install supervisor (which has no package on 12.04) to manage our processes
# the supervisor config file is more likely to change and is therefore added as a later step
RUN apt-get -y install python-setuptools
RUN easy_install supervisor
RUN mkdir -p /var/log/supervisor
# create directory for child images to store configuration in
RUN  mkdir -p /etc/supervisor/conf.d

# add supervisor conf files that will start when supervisord starts
ADD supervisor.conf /etc/supervisor.conf
ADD sshd.conf /etc/supervisor/conf.d/

ADD ssh-key-init.sh /opt/ssh-key-init.sh
RUN chmod +x /opt/ssh-key-init.sh

ADD start.sh /opt/start.sh
RUN chmod +x /opt/start.sh

CMD cd /opt && ./start.sh


