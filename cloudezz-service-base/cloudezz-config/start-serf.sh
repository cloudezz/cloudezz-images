#!/bin/bash
set -e

source /etc/environment
touch /opt/cloudezz-config/serf_output.txt

echo $IS_SERVICE >> serf_output.txt

# start serf with a node name, role and other values to start and join a cluster
exec serf agent -bind 0.0.0.0:7946 -node="$SERF_NODE_NAME" -tag serf_host_port="$SERF_HOST_PORT" -encrypt="$SERF_CLUSTER_KEY"  -tag cluster_id="$SERF_CLUSTER_ID"  -tag role="$SERF_ROLE"  -tag is_service="$IS_SERVICE"  -tag expose_default_port="$DEFAULT_PORT_TO_EXPOSE" -tag host_ip="$HOST_IP" -tag expose_default_host_port="$DEFAULT_HOST_PORT_TO_EXPOSE"  >> /opt/cloudezz-config/serf_output.txt

touch /opt/cloudezz-config/py_output.txt
exec python /opt/cloudezz-config/serfjoin.py >> py_output.txt





