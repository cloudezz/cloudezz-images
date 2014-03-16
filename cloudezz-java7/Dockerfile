FROM cloudezz/base

MAINTAINER bbytes  "info@beyondbytes.co.in"


RUN mkdir -p /usr/lib/jvm
RUN wget --no-cookies --no-check-certificate --header "Cookie: gpw_e24=http%3A%2F%2Fwww.oracle.com%2F; oraclelicense=accept-securebackup-cookie" "http://download.oracle.com/otn-pub/java/jdk/7u51-b13/jdk-7u51-linux-x64.tar.gz"
RUN mv jdk-7u51-linux-x64.tar.gz /usr/lib/jvm/
RUN cd /usr/lib/jvm && tar zxvf jdk-7u51-linux-x64.tar.gz
RUN cd /usr/lib/jvm && rm jdk-7u51-linux-x64.tar.gz
RUN ln -s -b /usr/lib/jvm/jdk1.7.0_51/jre/bin/java /etc/alternatives/java
RUN ln -s -b /usr/lib/jvm/jdk1.7.0_51/jre/bin/java /usr/bin/java
RUN echo "JAVA_HOME=/usr/lib/jvm/jdk1.7.0_51" >> /etc/environment

# setting up ant 
RUN wget http://www.us.apache.org/dist/ant/binaries/apache-ant-1.9.3-bin.tar.gz
RUN tar xvfvz apache-ant-1.9.3-bin.tar.gz -C /opt
RUN rm -f apache-ant-1.9.3-bin.tar.gz
RUN ln -s /opt/apache-ant-1.9.3 /opt/ant
RUN sh -c 'echo ANT_HOME=/opt/ant >> /etc/environment'
RUN ln -s /opt/ant/bin/ant /usr/bin/ant 
ENV ANT_HOME /opt/ant

# setting up maven 
RUN wget http://www.motorlogy.com/apache/maven/maven-3/3.2.1/binaries/apache-maven-3.2.1-bin.tar.gz
RUN tar xvfvz apache-maven-3.2.1-bin.tar.gz -C /opt
RUN rm -f apache-maven-3.2.1-bin.tar.gz
RUN ln -s /opt/apache-maven-3.2.1 /opt/maven
RUN sh -c 'echo ANT_HOME=/opt/maven >> /etc/environment'
RUN ln -s /opt/maven/bin/ant /usr/bin/ant 
ENV M2_HOME /opt/maven


# add default cloudezz init shell script  
# The default is called only when the used defined init file is not there in /cloudezz/app/cloudezz-config/cloudezz-init.sh
RUN mkdir -p /opt/cloudezz-config
ADD default-cloudezz-init.sh /opt/cloudezz-config/default-cloudezz-init.sh
RUN chmod +x /opt/cloudezz-config/default-cloudezz-init.sh

CMD cd /opt/cloudezz-config && ./start.sh



