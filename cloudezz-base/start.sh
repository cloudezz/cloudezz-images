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

# print the private key or ssh password on console so that the user can connect thru ssh
/opt/cloudezz-config/ssh-key-init.sh

if [ $GIT_URL ]
then
rm -r /cloudezz/app 
git clone $GIT_URL /cloudezz/app >/dev/null
fi

# start supervisord in daemon mode
service supervisor start


if [ -e "/cloudezz/app/cloudezz-config/cloudezz-init.sh" ]
then
 echo "Started cloudezz init script..." 
 chmod +x /cloudezz/app/cloudezz-config/cloudezz-init.sh
 /cloudezz/app/cloudezz-config/cloudezz-init.sh
else
	if [ -e "/opt/cloudezz-config/default-cloudezz-init.sh" ]
	then
		echo "Started default cloudezz init script..." 
		chmod +x /opt/cloudezz-config/default-cloudezz-init.sh
		/opt/cloudezz-config/default-cloudezz-init.sh
	fi	
fi




