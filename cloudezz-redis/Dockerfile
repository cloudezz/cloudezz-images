FROM cloudezz/servicebase

MAINTAINER bbytes  "info@beyondbytes.co.in"

RUN apt-get install -y python-software-properties sudo
RUN apt-add-repository -y ppa:chris-lea/redis-server
RUN apt-get update -qq
RUN apt-get install -y redis-server=2:2.8.3-1chl1~precise1


EXPOSE 6379

VOLUME ["/var/lib/redis"]

ADD redis-start.conf /etc/supervisor/conf.d/

ADD redis_start.sh /opt/redis_start.sh
RUN chmod +x /opt/redis_start.sh

CMD cd /opt && ./start.sh




