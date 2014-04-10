#!/bin/bash


echo "Member Joining to load balancer"

rm /tmp/listen.cfg

exec python serf_haproxy.py > /dev/null 2>&1 &

wait %2

echo "Member joined to load balancer"
