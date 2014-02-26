#!/bin/sh

ROOT_USR=root
CLOUDEZZ_USR=cloudezz


# This will generate a random, 8-character password:
#ROOT_SSH_PASSWD=`tr -dc A-Za-z0-9_ < /dev/urandom | head -c15`


# This will actually set the password for root and cloudezz user:
if [ $ROOT_SSH_PASSWD ]; then
echo "Creating new user $CLOUDEZZ_USR"
echo "Setting new ssh password for user $CLOUDEZZ_USR"
sudo su -c "useradd $CLOUDEZZ_USR -s /bin/bash -m -g sudo -G sudo" >/dev/null 2>/dev/null
sudo chpasswd << 'END'
$CLOUDEZZ_USR:$ROOT_SSH_PASSWD
END
echo "Setting new ssh password for user $ROOT_USR"
echo "$ROOT_USR:$ROOT_SSH_PASSWD" | chpasswd
fi 


# print the private key on console so that the user can connect thru ssh 
KEYGEN=/usr/bin/ssh-keygen
KEYFILE=/root/.ssh/id_rsa

if [ ! -f $KEYFILE ]; then
  $KEYGEN -q -t rsa -N "" -f $KEYFILE
  cat $KEYFILE.pub >> /root/.ssh/authorized_keys
fi

echo "== Use this private key to log in =="
cat $KEYFILE
