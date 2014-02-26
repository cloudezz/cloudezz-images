#!/bin/sh

# restart Fail2Ban service to avoid dos attack thru ssh
echo "Starting fail2ban service" 
sudo service fail2ban restart

# start Shell in a box service only when the webshell env is set to true
if [ ${WebShell} ] && [ "${WebShell}" == "true" ]
then
echo "Starting shellinabox service" 
sudo service shellinabox reload
sudo service shellinabox restart
fi


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
