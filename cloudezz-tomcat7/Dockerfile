FROM cloudezz/java7

MAINTAINER bbytes  "info@beyondbytes.co.in"

RUN mkdir -p /cloudezz/tomcat7
RUN mkdir -p /opt/cloudezz-config

ADD install-tomcat7.sh /opt/cloudezz-config/install-tomcat7.sh
RUN chmod +x /opt/cloudezz-config/install-tomcat7.sh
RUN /opt/cloudezz-config/install-tomcat7.sh

ENV JAVA_HOME /usr/lib/jvm/jdk1.7.0_51
ENV CATALINA_BASE /opt/apache-tomcat-7.0.52
ENV CATALINA_HOME /opt/apache-tomcat-7.0.52
ENV TOMCAT_HOME /opt/apache-tomcat-7.0.52

EXPOSE 8080

# all the data in these folders will be available after restart of container , it will be stored in host docker m/c
VOLUME ["/cloudezz/tomcat7/webapps-override", "/cloudezz/tomcat7/logs-override"]

ADD setenv.sh /opt/apache-tomcat-7.0.52/bin/setenv.sh
ADD server.xml /opt/apache-tomcat-7.0.52/conf/server.xml
ADD logging.properties /opt/apache-tomcat-7.0.52/conf/logging.properties

#start script 
ADD tomcat7 /etc/init.d/tomcat7
RUN chmod 755 /etc/init.d/tomcat7

# add default cloudezz init shell script  
# The default is called only when the used defined init file is not there in /cloudezz/app/cloudezz-config/cloudezz-init.sh
ADD default-cloudezz-init.sh /opt/cloudezz-config/default-cloudezz-init.sh
RUN chmod +x /opt/cloudezz-config/default-cloudezz-init.sh

CMD cd /opt/cloudezz-config && ./start.sh
