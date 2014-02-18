#!/bin/sh

# print the private key on console so that the user can connect thru ssh
/opt/ssh-key-init.sh

if [ ${gitURL} ]
then
rm -r /cloudezz/app 
git clone ${gitURL} /cloudezz/app >/dev/null
fi

if [ -e "/opt/init.sh" ]
then
 chmod +x /opt/init.sh
 /opt/init.sh
fi


# start supervisord in nodaemon mode
supervisord -n -c /etc/supervisor.conf
