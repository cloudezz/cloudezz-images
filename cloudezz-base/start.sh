#!/bin/sh


# restart Fail2Ban service to avoid dos attack thru ssh
echo "Starting fail2ban service"
service fail2ban restart >/dev/null

# start Shell in a box service only when the webshell env is set to true
if [ $WEB_SHELL ]
then
echo "Starting shellinabox service"
service shellinabox reload >/dev/null
fi

# start scout_realtime service only when the SERVER_METRICS env is set to true
if [ $SERVER_METRICS ]
then
echo "Starting scout realtime server and process metrics web app"
#fix for a bug in docker as it does not allow df command error -  df: cannot read table of mounted file systems
grep -v rootfs /proc/mounts > /etc/mtab
scout_realtime -p 4055 >/dev/null
fi


# print the private key on console so that the user can connect thru ssh
/opt/ssh-key-init.sh

if [ $GIT_URL ]
then
rm -r /cloudezz/app 
git clone $GIT_URL /cloudezz/app >/dev/null
fi

if [ -e "/opt/init.sh" ]
then
 chmod +x /opt/init.sh
 /opt/init.sh
fi


# start supervisord in nodaemon mode
supervisord -n -c /etc/supervisor.conf
