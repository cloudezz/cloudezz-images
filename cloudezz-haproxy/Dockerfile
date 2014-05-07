FROM cloudezz/servicebase

MAINTAINER bbytes  "info@beyondbytes.co.in"

# since HAProxy with ssl termincation is not available in 1.4 
# we need to add experimental deb pkg list to install 1.5 haproxy 

ENV DEBIAN_FRONTEND noninteractive
RUN echo "deb http://archive.ubuntu.com/ubuntu precise main universe" > /etc/apt/sources.list
RUN echo deb http://ftp.debian.org/debian experimental main >> /etc/apt/sources.list
RUN apt-get update
RUN apt-get upgrade -y

RUN apt-get install -y python-software-properties
RUN add-apt-repository ppa:vbernat/haproxy-1.5
RUN apt-get update
RUN apt-get upgrade -y
RUN apt-get dist-upgrade -y


RUN apt-get install -y haproxy 

# enable HAProxy to be started by the init script.
RUN echo "ENABLED=1" > /etc/default/haproxy

RUN rm /etc/haproxy/haproxy.cfg
ADD haproxy.cfg /etc/haproxy/
ADD cert.pem /etc/ssl/cert.pem

ADD haproxy-supervisord.conf /etc/supervisor/conf.d/

VOLUME ["/etc/haproxy"]

EXPOSE 80 443 9000

CMD cd /opt/cloudezz-config && ./start.sh




