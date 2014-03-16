#!/bin/sh

if [ $RUN_BUILD_PACK  ]
then
rm -r /opt/build-pack >/dev/null 2>/dev/null
wget -P /opt/build-pack/ https://github.com/cloudezz/cloudezz-node-build-pack/archive/master.zip  >/dev/null 2>/dev/null
chmod +x -R /opt/build-pack/
unzip /opt/build-pack/master.zip -d /opt/build-pack/  >/dev/null 2>/dev/null
chmod +x -R /opt/build-pack/ 
cd /opt/build-pack/cloudezz-node-build-pack-master && ant 
fi


# stop supervisord in daemon mode
supervisord stop
# start supervisord in non daemon mode as it has to keep the machine running else it will shutdown
supervisord -n -c /etc/supervisor.conf