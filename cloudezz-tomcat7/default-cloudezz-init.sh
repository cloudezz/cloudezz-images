#!/bin/sh

#Copy the war file from mounted directory to tomcat webapps directory
if [ ! -z "$WAR_URL" ]
then
echo "Removing old war files and copying $WAR_URL to tomcat webapps folder" 
rm -r /opt/tomcat7/webapps/*
cd /opt/tomcat7/webapps/  && wget -q $WAR_URL
fi


if [ $RUN_BUILD_PACK ]
then
rm -r /opt/build-pack >/dev/null 2>/dev/null
wget -P /opt/build-pack/ https://github.com/cloudezz/cloudezz-tomcat7-build-pack/archive/master.zip  >/dev/null 2>/dev/null
chmod +x -R /opt/build-pack/
unzip /opt/build-pack/master.zip -d /opt/build-pack/  >/dev/null 2>/dev/null
chmod +x -R /opt/build-pack/ 
cd /opt/build-pack/cloudezz-tomcat7-build-pack-master && ant 
fi

echo "Stop tomcat if running"
service tomcat7 stop >/dev/null 2>/dev/null
echo "Starting tomcat server on port 8080"
service tomcat7 start && tail -f /opt/tomcat7/logs/catalina.out
