#!/bin/bash

touch /opt/cloudezz-config/join_output.txt

echo ${SERF_TAG_IS_SERVICE} >> join_output.txt

if [ "${SERF_TAG_IS_SERVICE}" != "false" ]; then
    echo "Not an lb. Ignoring member join." >> join_output.txt
    exit 0
fi


echo "Member Joining to LB" >> join_output.txt

rm /tmp/listen.cfg

exec python serf_haproxy.py


cat /opt/cloudezz-config/haproxy.cfg.base /tmp/listen.cfg > /opt/cloudezz-config/haproxy.cfg

supervisorctl restart haproxy