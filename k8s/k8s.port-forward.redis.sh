#!/bin/bash
# port forwarding to k8s redis (via service)

if [ -z "$1" ]; then
  echo "Error: 'namespace' value missing → provide it to port forward to this namespace"
  exit 1
fi

kubectl -n $1 port-forward svc/redis-db-service 7379:6379
