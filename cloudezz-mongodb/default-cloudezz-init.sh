#!/bin/bash

if [ ! -f /opt/cloudezz-config/.mongodb_user_password_set ]; then
/opt/cloudezz-config/set_mongo_user_password.sh
fi

exec /usr/bin/mongod --nojournal --auth
