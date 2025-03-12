#!/bin/bash

NODES=$(kubectl get nodes)

echo "$NODES" | grep "worker" | awk '{print $1}'