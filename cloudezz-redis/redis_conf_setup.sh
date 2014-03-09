#!/bin/bash
set -e 

chown -R root:root /var/lib/redis

if [ $REDIS_PASSWORD ]
then
echo "Starting redis server with password $REDIS_PASSWORD"
echo "requirepass $REDIS_PASSWORD" > /etc/redis/redis_cloudezz.conf
else
echo "Starting redis server..."
echo "" > /etc/redis/redis_cloudezz.conf
fi