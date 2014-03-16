FROM cloudezz/nodejs

MAINTAINER bbytes  "info@beyondbytes.co.in"

RUN mkdir -p /cloudezz/data
RUN mkdir -p /cloudezz/app

ENV GHOST_VERSION 0.4.1
ENV APP_ROOT /cloudezz/app

RUN curl -sLO http://ghost.org/archives/ghost-$GHOST_VERSION.zip
RUN mkdir -p $APP_ROOT && unzip -uo ghost-$GHOST_VERSION.zip -d $APP_ROOT
RUN rm ghost-$GHOST_VERSION.zip
RUN cd $APP_ROOT && npm install --production

EXPOSE 2368

RUN rm /usr/sbin/policy-rc.d

RUN cat /tmp/tomcat7.settings > /etc/default/tomcat7
RUN cat /tmp/server.xml > /var/lib/tomcat7/conf/server.xml
RUN cat /tmp/logging.properties > /var/lib/tomcat7/logging.properties

CMD cd /opt/cloudezz-config && ./start.sh
