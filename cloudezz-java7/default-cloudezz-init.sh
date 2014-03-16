#!/bin/sh

# stop supervisord in daemon mode
supervisord stop
# start supervisord in non daemon mode as it has to keep the machine running else it will shutdown
supervisord -n -c /etc/supervisor.conf