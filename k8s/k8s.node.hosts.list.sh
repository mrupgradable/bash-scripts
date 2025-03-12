#!/bin/bash
# Script to extract hostnames from k8s

get_node_names() {
    local nodes=$(kubectl get nodes -o wide | awk 'NR>1 {print $1}')

    if [ -z "$nodes" ]; then
        echo "Error: No nodes found or kubectl command failed"
        exit 1
    fi

    echo "$nodes"
}

NODE_NAMES=$(get_node_names)
echo $NODE_NAMES
