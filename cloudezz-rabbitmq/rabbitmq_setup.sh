#!/bin/bash
echo "Enabling rabbitmq_management ..."
/usr/sbin/rabbitmq-plugins enable rabbitmq_management >/dev/null

# Start rabbitmq server 
echo "Starting rabbitmq server ..."
service rabbitmq-server start >/dev/null

RABBITMQ_USER=${RABBITMQ_USER:-"admin"}
RABBITMQ_PASSWORD=${RABBITMQ_PASSWORD:-"d1ff1cult@123"}

chown -R rabbitmq:rabbitmq /var/lib/rabbitmq

echo "Removing 'guest' user and adding '$RABBITMQ_USER' user to rabbitmq with password '$RABBITMQ_PASSWORD'"
/usr/sbin/rabbitmqctl add_user $RABBITMQ_USER $RABBITMQ_PASSWORD >/dev/null
/usr/sbin/rabbitmqctl set_user_tags $RABBITMQ_USER administrator >/dev/null
/usr/sbin/rabbitmqctl set_permissions -p / $RABBITMQ_USER ".*" ".*" ".*" >/dev/null
/usr/sbin/rabbitmqctl delete_user guest >/dev/null

# Stop rabbitmq server 
echo "Stopping rabbitmq server ..."
service rabbitmq-server stop >/dev/null

# Starting rabbitmq server after adding admin user 
echo "Restarting rabbitmq server after adding $RABBITMQ_USER user..."
service rabbitmq-server start