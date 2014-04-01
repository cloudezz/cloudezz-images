#!/bin/bash

touch /opt/cloudezz-config/join_output.txt

echo ${SERF_TAG_${IS_SERVICE}} >> join_output.txt

if [ "x${SERF_TAG_${IS_SERVICE}}" != "true" ]; then
    echo "Not an lb. Ignoring member join." >> join_output.txt
    exit 0
fi

touch /opt/cloudezz-config/join_output.txt

rm /tmp/frontend.cfg
rm /tmp/backend.cfg

serf members -tag is_service=true -status=alive | while read host ip status tags; do
    if [[ -z $tags ]]; then exit 0; fi

    declare -A hash
    IFS=',' read -a array <<< "$tags"
    for i in "${array[@]}"; do IFS="=" read k v <<< "$i"; hash[$k]=$v; done

    IFS=";" read -a frontend  <<< "${hash["frontend"]}"
    for i in "${frontend[@]}"; do echo "$i" >> /tmp/frontend.cfg; done
     
    IFS=";" read -a backend  <<< "${hash["backend"]}"
    for i in "${backend[@]}"; do echo "$i" >> /tmp/backend.cfg; done
done

cat /opt/cloudezz-config/haproxy.cfg.base /tmp/frontend.cfg /tmp/backend.cfg > /opt/cloudezz-config/haproxy.cfg

supervisorctl restart haproxy