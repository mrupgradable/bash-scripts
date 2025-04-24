#!/bin/bash
# script to drain supplied worker node

node=$1

echo "Draining node: $node"
kubectl drain "$node" --ignore-daemonsets --delete-emptydir-data --force
