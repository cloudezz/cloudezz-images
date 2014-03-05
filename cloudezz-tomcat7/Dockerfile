FROM cloudezz/base

MAINTAINER bbytes  "info@beyondbytes.co.in"

RUN apt-get -y install maven
RUN apt-get -y install tomcat7
RUN echo "JAVA_HOME=/usr/lib/jvm/java-7-oracle" >> /etc/default/tomcat7

RUN sed -i "s|-Xmx128m|-Xmx2024m|g" /etc/default/tomcat7

EXPOSE 8080

ADD tomcat.conf /etc/supervisor/conf.d/
ADD tomcat7.settings /tmp/tomcat7.settings
ADD server.xml /tmp/server.xml
ADD logging.properties /tmp/logging.properties
ADD deploy_run.sh /opt/deploy_run.sh
RUN chmod +x /opt/deploy_run.sh

RUN cat /tmp/tomcat7.settings > /etc/default/tomcat7
RUN cat /tmp/server.xml > /var/lib/tomcat7/conf/server.xml
RUN cat /tmp/logging.properties > /var/lib/tomcat7/logging.properties

ADD init.sh /opt/init.sh

CMD cd /opt && ./start.sh
