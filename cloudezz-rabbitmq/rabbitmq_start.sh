#!/bin/bash

# Starting rabbitmq server after adding admin user 
echo "Restarting rabbitmq server after adding $RABBITMQ_USER user..."
service rabbitmq-server start