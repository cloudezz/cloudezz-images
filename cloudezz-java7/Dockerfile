FROM cloudezz/base

MAINTAINER bbytes  "info@beyondbytes.co.in"

# Setting up java 7
RUN rm /var/lib/dpkg/info/oracle-java7-installer* 
RUN apt-get purge oracle-java7-installer* 
RUN rm /etc/apt/sources.list.d/*java* 
RUN apt-get update 
RUN add-apt-repository ppa:webupd8team/java -y

RUN apt-get update
RUN echo oracle-java7-installer shared/accepted-oracle-license-v1-1 select true | /usr/bin/debconf-set-selections

# and install java 7 oracle jdk
RUN apt-get -y install oracle-java7-installer && apt-get clean

RUN update-alternatives --display java
RUN echo "JAVA_HOME=/usr/lib/jvm/java-7-oracle" >> /etc/environment

# setting up ant 
RUN wget http://www.us.apache.org/dist/ant/binaries/apache-ant-1.9.3-bin.tar.gz
RUN tar xvfvz apache-ant-1.9.3-bin.tar.gz -C /opt
RUN ln -s /opt/apache-ant-1.9.3 /opt/ant
RUN sh -c 'echo ANT_HOME=/opt/ant >> /etc/environment'
RUN ln -s /opt/ant/bin/ant /usr/bin/ant 
ENV ANT_HOME /opt/ant

# setting up maven 
RUN apt-get -y install maven

CMD cd /opt && ./start.sh



