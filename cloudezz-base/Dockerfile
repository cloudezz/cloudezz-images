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

# NOTE: Create base folders
RUN mkdir -p /cloudezz
RUN mkdir -p /cloudezz/app
RUN mkdir -p /cloudezz/data

# Install some packages we need
RUN apt-get install -y rinetd
RUN apt-get install -y joe
RUN apt-get install -y git-core

# Setting up java 7
RUN apt-get install -y python-software-properties
RUN apt-get install -y software-properties-common
RUN add-apt-repository ppa:webupd8team/java -y

RUN apt-get update
RUN echo oracle-java7-installer shared/accepted-oracle-license-v1-1 select true | /usr/bin/debconf-set-selections

# and install java 7 oracle jdk
RUN apt-get -y install oracle-java7-installer && apt-get clean
RUN update-alternatives --display java
ENV JAVA_HOME /usr/lib/jvm/java-7-oracle


# setting up ant 
RUN wget http://www.us.apache.org/dist/ant/binaries/apache-ant-1.9.3-bin.tar.gz
RUN tar xvfvz apache-ant-1.9.3-bin.tar.gz -C /opt
RUN ln -s /opt/apache-ant-1.9.3 /opt/ant
RUN sh -c 'echo ANT_HOME=/opt/ant >> /etc/environment'
RUN ln -s /opt/ant/bin/ant /usr/bin/ant 
ENV ANT_HOME /opt/ant


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
ADD port_mapping.conf /etc/supervisor/conf.d/


ADD port_mapping.sh /opt/port_mapping.sh
RUN chmod +x /opt/port_mapping.sh

ADD ssh-key-init.sh /opt/ssh-key-init.sh
RUN chmod +x /opt/ssh-key-init.sh

ADD start.sh /opt/start.sh
RUN chmod +x /opt/start.sh

CMD cd /opt && ./start.sh


