#!/bin/sh

# print the private key on console so that the user can connect thru ssh 
KEYGEN=/usr/bin/ssh-keygen
KEYFILE=/root/.ssh/id_rsa

if [ ! -f $KEYFILE ]; then
  $KEYGEN -q -t rsa -N "" -f $KEYFILE
  cat $KEYFILE.pub >> /root/.ssh/authorized_keys
fi

echo "== Use this private key to log in =="
cat $KEYFILE