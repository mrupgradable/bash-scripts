#!/bin/bash
# take down k8s nodes (starting with workers, then master)

# take down k8s cluster
cd ~/bash-scripts/k8s
./k8s.cluster.down.sh

# take down operator
cd ~/bash-scripts/server
./operator.remote.shutdown.sh

