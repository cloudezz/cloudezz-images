#!/bin/sh

USR=root

# This will generate a random, 8-character password:
#ROOT_SSH_PASSWD=`tr -dc A-Za-z0-9_ < /dev/urandom | head -c15`

# This will actually set the password:
if [ -z "$ROOT_SSH_PASSWD" ]; then
echo "$USR:$PASS" | chpasswd
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
