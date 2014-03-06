#!/bin/sh

rm -r /opt/build-pack >/dev/null 2>/dev/null
wget -P /opt/build-pack/ https://github.com/cloudezz/cloudezz-tomcat7-build-pack/archive/master.zip  >/dev/null 2>/dev/null
chmod +x -R /opt/build-pack/
unzip /opt/build-pack/master.zip -d /opt/build-pack/  >/dev/null 2>/dev/null
chmod +x -R /opt/build-pack/ 
cd /opt/build-pack/cloudezz-tomcat7-build-pack-master && ant 
