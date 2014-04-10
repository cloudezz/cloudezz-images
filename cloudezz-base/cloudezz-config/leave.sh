#!/bin/bash


echo "Member Leaving from LB"

rm /tmp/listen.cfg

exec python serf_haproxy.py > /dev/null 2>&1 &

wait %2

echo "Member Left from LB"