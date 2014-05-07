FROM cloudezz/servicebase

MAINTAINER bbytes  "info@beyondbytes.co.in"

# Make sure that Upstart won't try to start RabbitMQ after apt-get installs it
# https://github.com/dotcloud/docker/issues/446
ADD policy-rc.d /usr/sbin/policy-rc.d
RUN /bin/chmod 755 /usr/sbin/policy-rc.d

# Another way to work around Upstart problems
# https://www.nesono.com/node/368
# RUN dpkg-divert --local --rename --add /sbin/initctl
# RUN ln -s /bin/true /sbin/initctl

ENV DEBIAN_FRONTEND noninteractive


ADD rabbitmq-signing-key-public.asc /opt/cloudezz-config/rabbitmq-signing-key-public.asc
RUN apt-key add /opt/cloudezz-config/rabbitmq-signing-key-public.asc

RUN echo "deb http://www.rabbitmq.com/debian/ testing main" > /etc/apt/sources.list.d/rabbitmq.list
RUN apt-get -qq update > /dev/null
RUN apt-get -qq -y install rabbitmq-server > /dev/null

ADD rabbitmq_setup.sh /opt/cloudezz-config/rabbitmq_setup.sh
RUN chmod +x /opt/cloudezz-config/rabbitmq_setup.sh


VOLUME ["/var/lib/rabbitmq/mnesia"]

EXPOSE 5672 15672 4369

CMD cd /opt/cloudezz-config && ./rabbitmq_setup.sh && ./start.sh





