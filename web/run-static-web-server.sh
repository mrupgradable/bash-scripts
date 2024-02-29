#!/bin/bash
#
# run a simple python webserver over current dir (which you are in)
# to change the port provide this as an argument
#
# e.g. run-static-web-server.sh
# e.g. run-static-web-server.sh 8145

CURRENT_DIR=$PWD
WEB_SERVER_PORT=${1:-8080}

echo "Running python webserver over dir:$CURRENT_DIR"

python3 -m http.server ${WEB_SERVER_PORT} --directory $CURRENT_DIR

