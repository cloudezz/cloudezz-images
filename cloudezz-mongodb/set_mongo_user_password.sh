#!/bin/sh

#!/bin/bash

if [ -f /opt/cloudezz-config/.mongodb_user_password_set ]; then
echo "MongoDB password already set!"
exit 0
fi

/usr/bin/mongod --smallfiles & 
sleep 3
USER=${MONGODB_USER:-"admin"}
PASS=${MONGODB_PASSWD:-$(pwgen -s 12 1)}
echo "=============================================================================="
echo "Creating admin privilege user '$USER' with password '$PASS' in MongoDB"
echo "=============================================================================="
mongo admin --eval "db.addUser( { user: '$USER', pwd: '$PASS', roles: [ 'userAdminAnyDatabase', 'dbAdminAnyDatabase' ] } );"
mongo admin --eval "db.shutdownServer();"
sleep 3

echo "=> Done!"
touch /opt/cloudezz-config/.mongodb_user_password_set

