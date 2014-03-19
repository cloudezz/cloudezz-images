FROM cloudezz/java7

MAINTAINER bbytes  "info@beyondbytes.co.in"

# setting up tomcat7
RUN wget http://mirrors.advancedhosters.com/apache/tomcat/tomcat-7/v7.0.52/bin/apache-tomcat-7.0.52.tar.gz
RUN tar xvfvz apache-tomcat-7.0.52.tar.gz -C /opt
RUN rm -f apache-tomcat-7.0.52.tar.gz
RUN ln -s /opt/apache-tomcat-7.0.52 /opt/tomcat7

RUN echo "JAVA_HOME=/usr/lib/jvm/jdk1.7.0_51" >> /etc/environment
RUN echo "CATALINA_BASE=opt/apache-tomcat-7.0.52" >> /etc/environment
RUN echo "CATALINA_HOME=opt/apache-tomcat-7.0.52" >> /etc/environment
RUN echo "TOMCAT_HOME=opt/apache-tomcat-7.0.52" >> /etc/environment
ENV JAVA_HOME /usr/lib/jvm/jdk1.7.0_51
ENV CATALINA_BASE /opt/apache-tomcat-7.0.52
ENV CATALINA_HOME /opt/apache-tomcat-7.0.52
ENV TOMCAT_HOME /opt/apache-tomcat-7.0.52

EXPOSE 8080

# all the data in these folders will be available after restart of container , it will be stored in host docker m/c
VOLUME /opt/tomcat7/webapps
VOLUME /opt/tomcat7/logs


ADD setenv.sh /opt/apache-tomcat-7.0.52/bin/setenv.sh
ADD server.xml /opt/apache-tomcat-7.0.52/conf/server.xml
ADD logging.properties /opt/apache-tomcat-7.0.52/conf/logging.properties

#start script 
ADD tomcat7 /etc/init.d/tomcat7
RUN chmod 755 /etc/init.d/tomcat7


# add default cloudezz init shell script  
# The default is called only when the used defined init file is not there in /cloudezz/app/cloudezz-config/cloudezz-init.sh
RUN mkdir -p /opt/cloudezz-config
ADD default-cloudezz-init.sh /opt/cloudezz-config/default-cloudezz-init.sh
RUN chmod +x /opt/cloudezz-config/default-cloudezz-init.sh


CMD cd /opt/cloudezz-config && ./start.sh
