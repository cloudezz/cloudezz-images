FROM cloudezz/servicebase

MAINTAINER bbytes  "info@beyondbytes.co.in"

ENV DEBIAN_FRONTEND noninteractive
RUN apt-get update -qq
RUN apt-get install -y haproxy

# enable HAProxy to be started by the init script.
RUN echo"ENABLED=1" > /etc/default/haproxy

RUN rm /etc/haproxy/haproxy.cfg
ADD haproxy.cfg /etc/haproxy/
ADD cert.pem /etc/ssl/cert.pem

ADD haproxy-supervisord.conf /etc/supervisor/conf.d/

VOLUME ["/etc/haproxy"]

EXPOSE 80 443 9000

CMD cd /opt && ./start.sh




