#!/bin/sh



rm -r /opt/build-pack >/dev/null
git clone https://github.com/bbytes/cloudezz.git /opt/build-pack >/dev/null
chmod +x -R /opt/build-pack/cloudezz-build-pack 
cd /opt/build-pack/cloudezz-build-pack/cloudezz-tomcat7-build-pack && ant 
