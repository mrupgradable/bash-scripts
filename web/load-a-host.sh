#!/bin/bash
#
# load a host using a docker container
# simple load generator
# use hostname or ip as arg
#
# e.g. load-a-host.sh
# e.g. load-a-host.sh 127.0.1.1
# e.g. load-a-host.sh localhost

HOST_TO_LOAD=${1:-localhost}

echo "Running load to host:${HOST_TO_LOAD}"

docker run --rm -it busybox:1.28 /bin/sh -c "while sleep 0.01; do wget -q -O- http://${HOST_TO_LOAD}; done"


