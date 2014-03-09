FROM cloudezz/servicebase

MAINTAINER bbytes  "info@beyondbytes.co.in"

RUN echo deb http://archive.ubuntu.com/ubuntu precise main universe multiverse > /etc/apt/sources.list
RUN apt-get update -qq
RUN apt-get install -y python-software-properties
RUN add-apt-repository -y ppa:chris-lea/redis-server
RUN apt-get update -qq
RUN apt-get install -y redis-server

EXPOSE 6379

VOLUME ["/var/lib/redis"]

ADD redis-start.conf /etc/supervisor/conf.d/

ADD redis_start.sh /opt/redis_start.sh
RUN chmod +x /opt/redis_start.sh

CMD cd /opt && ./start.sh




