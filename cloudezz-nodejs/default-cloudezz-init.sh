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


#	way to stop and start supervisord

#	# stop supervisord in daemon mode
#	service supervisor stop
#	# fix based on http://stackoverflow.com/questions/14479894/stopping-supervisord-shut-down
#	unlink /var/run/supervisor.sock 2> /dev/null
#	unlink /tmp/supervisor.sock 2> /dev/null
#	# start supervisord in non daemon mode as it has to keep the machine running else it will shutdown
#	echo "Starting supervisord in foreground ..."
#	service supervisor start

# run this to keep the container running ..as the container needs a foreground task to run to keep it alive 
tail -100f /var/log/supervisor/supervisord.log
