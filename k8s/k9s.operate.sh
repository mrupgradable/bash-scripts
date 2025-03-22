#!/bin/bash
# operate k8s cluster with k9s (docker'd for isolation)
#
# CTL + C (exit) 
#
# note: needs adequate roles
#       needs k8s metrics server installed
#
# issues: 1. docker.processes (obtain container id)
#         2. docker.shell <container-id>
#         3. k9s info (see log path)
#         4. investigate log

echo "starting k9s"

docker run --rm -it -v $HOME/.kube/config:/root/.kube/config derailed/k9s
