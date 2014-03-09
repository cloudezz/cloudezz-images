#!/bin/bash
set -e 

chown -R redis:redis /var/lib/redis

echo "Starting redis server..."
if [ $REDIS_PASSWORD ]
then
exec sudo -u redis /usr/bin/redis-server --requirepass $REDIS_PASSWORD >/dev/null
else
exec sudo -u redis /usr/bin/redis-server >/dev/null
fi

