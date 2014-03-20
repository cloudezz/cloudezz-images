#!/bin/sh

if [ -f /opt/cloudezz-config/.mongodb_user_password_set ]; then
echo "MongoDB password already set!"
exit 0
fi

/usr/bin/mongod --smallfiles &
sleep 3
USER=${MONGODB_USER:-"admin"}
PASS=${MONGODB_PASSWD:-$(pwgen -s 12 1)}
echo "=> Creating an admin privilege user '$USER' with '$PASS' password in MongoDB"
use admin;
db.addUser({ user:'$USER', pwd:'$PASS', roles:["dbAdminAnyDatabase","clusterAdmin"]});
db.shutdownServer();
sleep 3

echo "=> Done!"
touch /opt/cloudezz-config/.mongodb_user_password_set