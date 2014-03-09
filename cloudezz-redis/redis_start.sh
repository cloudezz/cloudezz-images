#!/bin/bash
set -e 

chown -R root:root /var/lib/redis

if [ $REDIS_PASSWORD ]
then
echo "Starting redis server with password $REDIS_PASSWORD"
exec  /usr/bin/redis-server --requirepass $REDIS_PASSWORD >/dev/null
else
echo "Starting redis server..."
exec  /usr/bin/redis-server >/dev/null
fi