#!/bin/bash

echo came into port mapping ..
echo adding tcp port forwarding info to rinetd service ..

service rinetd stop

IFS=',' read -a array <<< "$TCP_FORWARD"

# empty the conf file before adding the mapping info
echo clearing old content in rinetd.conf before adding mapping info..
echo "" > /etc/rinetd.conf

for element in "${array[@]}"
do
    echo "$element"
    echo "$element" >> /etc/rinetd.conf
done

rinetd -f


