#!/bin/bash
# port forwarding to k8s cluster service + namespace

echo "k port-forward svc/redis-db-service 7379:6379 -n $1" | xclip -selection clipboard
