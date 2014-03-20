#!/bin/bash

if [ ! -f /opt/cloudezz-config/.mongodb_password_set ]; then
/opt/cloudezz-config/set_mongodb_password.sh
fi

exec /usr/bin/mongod --nojournal --auth
