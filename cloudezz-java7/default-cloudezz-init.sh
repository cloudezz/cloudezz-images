#!/bin/sh

# stop supervisord in daemon mode
service supervisor stop
# fix based on http://stackoverflow.com/questions/14479894/stopping-supervisord-shut-down
unlink /var/run/supervisor.sock 2> /dev/null
unlink /tmp/supervisor.sock 2> /dev/null
# start supervisord in non daemon mode as it has to keep the machine running else it will shutdown
echo "Starting supervisord in foreground ..."
mv -f /opt/cloudezz-config/supervisorND.conf /etc/supervisor/supervisor.conf
mv -f /opt/cloudezz-config/supervisorND.conf /etc/supervisor.conf
service supervisor start