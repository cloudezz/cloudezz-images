FROM cloudezz/servicebase

MAINTAINER bbytes  "info@beyondbytes.co.in"

USER root

# Make sure that Upstart won't try to start RabbitMQ after apt-get installs it
# https://github.com/dotcloud/docker/issues/446
ADD policy-rc.d /usr/sbin/policy-rc.d
RUN /bin/chmod 755 /usr/sbin/policy-rc.d

# Another way to work around Upstart problems
# https://www.nesono.com/node/368
# RUN dpkg-divert --local --rename --add /sbin/initctl
# RUN ln -s /bin/true /sbin/initctl

ENV DEBIAN_FRONTEND noninteractive

VOLUME ["/var/lib/rabbitmq/mnesia"]

EXPOSE 5672 15672 4369

ADD rabbitmq-signing-key-public.asc /tmp/rabbitmq-signing-key-public.asc
RUN apt-key add /tmp/rabbitmq-signing-key-public.asc

RUN echo "deb http://www.rabbitmq.com/debian/ testing main" > /etc/apt/sources.list.d/rabbitmq.list
RUN apt-get -qq update > /dev/null
RUN apt-get -qq -y install rabbitmq-server > /dev/null

ADD rabbitmq.conf /etc/supervisor/conf.d/

ADD rabbitmq_setup.sh /opt/rabbitmq_setup.sh
RUN chmod +x /opt/rabbitmq_setup.sh

CMD cd /opt && ./rabbitmq_setup.sh && ./start.sh




