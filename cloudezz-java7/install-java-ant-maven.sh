#!/bin/sh

mkdir -p /usr/lib/jvm
wget --no-cookies --no-check-certificate --header "Cookie: gpw_e24=http%3A%2F%2Fwww.oracle.com%2F; oraclelicense=accept-securebackup-cookie" "http://download.oracle.com/otn-pub/java/jdk/7u51-b13/jdk-7u51-linux-x64.tar.gz"
mv jdk-7u51-linux-x64.tar.gz /usr/lib/jvm/
cd /usr/lib/jvm && tar zxvf jdk-7u51-linux-x64.tar.gz
cd /usr/lib/jvm && rm jdk-7u51-linux-x64.tar.gz
ln -s -b /usr/lib/jvm/jdk1.7.0_51/jre/bin/java /etc/alternatives/java
ln -s -b /usr/lib/jvm/jdk1.7.0_51/jre/bin/java /usr/bin/java
echo "JAVA_HOME=/usr/lib/jvm/jdk1.7.0_51" >> /etc/environment


# setting up ant 
wget http://www.us.apache.org/dist/ant/binaries/apache-ant-1.9.3-bin.tar.gz
tar xvfvz apache-ant-1.9.3-bin.tar.gz -C /opt
rm -f apache-ant-1.9.3-bin.tar.gz
ln -s /opt/apache-ant-1.9.3 /opt/ant
sh -c 'echo ANT_HOME=/opt/ant >> /etc/environment'
ln -s /opt/ant/bin/ant /usr/bin/ant 


# setting up maven 
wget http://www.motorlogy.com/apache/maven/maven-3/3.2.1/binaries/apache-maven-3.2.1-bin.tar.gz
tar xvfvz apache-maven-3.2.1-bin.tar.gz -C /opt
rm -f apache-maven-3.2.1-bin.tar.gz
ln -s /opt/apache-maven-3.2.1 /opt/maven
sh -c 'echo ANT_HOME=/opt/maven >> /etc/environment'
ln -s /opt/maven/bin/mvn /usr/bin/mvn 