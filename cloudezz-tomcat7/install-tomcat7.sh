#!/bin/sh

# setting up tomcat7
wget http://archive.apache.org/dist/tomcat/tomcat-7/v7.0.52/bin/apache-tomcat-7.0.52.tar.gz
tar xvfvz apache-tomcat-7.0.52.tar.gz -C /opt
rm -f apache-tomcat-7.0.52.tar.gz
ln -s /opt/apache-tomcat-7.0.52 /opt/tomcat7

echo "JAVA_HOME=/usr/lib/jvm/jdk1.7.0_51" >> /etc/environment
echo "CATALINA_BASE=opt/apache-tomcat-7.0.52" >> /etc/environment
echo "CATALINA_HOME=opt/apache-tomcat-7.0.52" >> /etc/environment
echo "TOMCAT_HOME=opt/apache-tomcat-7.0.52" >> /etc/environment