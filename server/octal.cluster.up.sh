#!/bin/bash
# nodes should be up, ensure are completely ready

# bring up operator
cd ~/bash-scripts/server
echo "operator should be up..."
ping -c 1 operator.octal.castlenet.local

# bring up k8s cluster
cd ~/bash-scripts/k8s
./k8s.cluster.up.sh
