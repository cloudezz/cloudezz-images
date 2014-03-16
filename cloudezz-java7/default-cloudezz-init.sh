#!/bin/sh

# stop supervisord in daemon mode
service supervisor stop
# fix based on http://stackoverflow.com/questions/14479894/stopping-supervisord-shut-down
unlink /var/run/supervisor.sock 2> /dev/null
# start supervisord in non daemon mode as it has to keep the machine running else it will shutdown
supervisord -n -c /etc/supervisor.conf