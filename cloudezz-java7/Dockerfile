FROM cloudezz/base

MAINTAINER bbytes  "info@beyondbytes.co.in"

RUN mkdir -p /opt/cloudezz-config
ADD install-java-ant-maven.sh /opt/cloudezz-config/install-java-ant-maven.sh
RUN chmod +x /opt/cloudezz-config/install-java-ant-maven.sh
RUN /opt/cloudezz-config/install-java-ant-maven.sh

ENV JAVA_HOME /usr/lib/jvm/jdk1.7.0_51
ENV ANT_HOME /opt/ant
ENV M2_HOME /opt/maven

# add default cloudezz init shell script  
# The default is called only when the used defined init file is not there in /cloudezz/app/cloudezz-config/cloudezz-init.sh
ADD default-cloudezz-init.sh /opt/cloudezz-config/default-cloudezz-init.sh
RUN chmod +x /opt/cloudezz-config/default-cloudezz-init.sh

CMD cd /opt/cloudezz-config && ./start.sh



