#!/bin/sh

touch /opt/cloudezz-config/output.txt
# start serf with a node name, role and other values to start and join a cluster
exec serf agent -bind 0.0.0.0:7946 -event-handler "member-join=/opt/cloudezz-config/join.sh" -event-handler "member-leave,member-failed=/opt/cloudezz-config/leave.sh" -node=$SERF_NODE_NAME -encrypt=$SERF_CLUSTER_KEY  -tag cluster_id=$SERF_CLUSTER_ID  -tag role=$SERF_ROLE  -tag is_service=$SERVICE_OR_NOT  -tag expose_default_port=$DEFAULT_PORT_TO_EXPOSE >> /opt/cloudezz-config/output.txt

exec python serfjoin.py





