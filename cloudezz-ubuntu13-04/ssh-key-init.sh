#!/bin/sh

# This will generate a random, 8-character password:
#ROOT_SSH_PASSWD=`tr -dc A-Za-z0-9_ < /dev/urandom | head -c15`


# This will actually set the password for root and cloudezz user:
if [ $ROOT_SSH_PASSWD ]; then
echo "Creating new user cloudezz"
echo "Setting ssh password for user cloudezz"
sudo userdel cloudezz >/dev/null 2>/dev/null
sudo su -c "useradd cloudezz -s /bin/bash -m -g sudo -G sudo" >/dev/null 2>/dev/null
echo "cloudezz:$ROOT_SSH_PASSWD" | chpasswd
echo "Setting ssh password for user root"
echo "root:$ROOT_SSH_PASSWD" | chpasswd
fi




# print the private key on console so that the user can connect thru ssh 
KEYGEN=/usr/bin/ssh-keygen
KEYFILE=/root/.ssh/id_rsa


if [ ! -f $KEYFILE ]; then
  $KEYGEN -q -t rsa -N "" -f $KEYFILE
  cat $KEYFILE.pub >> /root/.ssh/authorized_keys
fi

# if the root shh password is missing then print private key
if [ ! $ROOT_SSH_PASSWD  ]; then
echo "== Use this private key to log in =="
cat $KEYFILE
fi

