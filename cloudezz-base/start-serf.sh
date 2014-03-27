#!/bin/sh

# start serf with a node name, role and other values to start and join a cluster
exec serf agent -bind 0.0.0.0:7946 -node=$SERF_NODE_NAME -encrypt=$SERF_CLUSTER_KEY  -tag cluster_id=$SERF_CLUSTER_ID  -tag role=$SERF_ROLE  -tag is_service=$SERVICE_OR_NOT  -tag expose_default_port=$DEFAULT_PORT_TO_EXPOSE 



