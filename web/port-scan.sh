#!/bin/bash
#
# scan ports using nc
# will can localhost by default and on port 8080
# use hostname as 2nd arg
#
# e.g. port-scan.sh
# e.g. port-scan.sh 80
# e.g. port-scan.sh 8000-8080
# e.g. port-scan.sh 80 localhost

SCAN_PORT_RANGE=${1:-8080}
SCAN_HOST=${2:-localhost}

echo "Running nc to scan host:${SCAN_HOST} ports:${SCAN_PORT_RANGE}"

nc -z -v ${SCAN_HOST} ${SCAN_PORT_RANGE}

