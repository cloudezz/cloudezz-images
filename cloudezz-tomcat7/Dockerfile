FROM cloudezz/java7

MAINTAINER bbytes  "info@beyondbytes.co.in"

RUN apt-get -y install tomcat7
RUN echo "JAVA_HOME=/usr/lib/jvm/jdk1.7.0_51" >> /etc/default/tomcat7

RUN sed -i "s|-Xmx128m|-Xmx2024m|g" /etc/default/tomcat7

EXPOSE 8080

ADD tomcat7.settings /tmp/tomcat7.settings
ADD server.xml /tmp/server.xml
ADD logging.properties /tmp/logging.properties


# all the data in these folders will be available after restart of container , it will be stored in host docker m/c
VOLUME  ["/var/lib/tomcat7", "/var/log/tomcat7"]

# add default cloudezz init shell script  
# The default is called only when the used defined init file is not there in /cloudezz/app/cloudezz-config/cloudezz-init.sh
RUN mkdir -p /opt/cloudezz-config
ADD default-cloudezz-init.sh /opt/cloudezz-config/default-cloudezz-init.sh
RUN chmod +x /opt/cloudezz-config/default-cloudezz-init.sh


RUN cat /tmp/tomcat7.settings > /etc/default/tomcat7
RUN cat /tmp/server.xml > /var/lib/tomcat7/conf/server.xml
RUN cat /tmp/logging.properties > /var/lib/tomcat7/logging.properties

CMD cd /opt/cloudezz-config && ./start.sh
