#!/bin/bash

WORKER_NODES=$(./k8s.worker.nodes.sh)

# Counter for processed nodes
count=0
total=$(echo "$WORKER_NODES" | wc -l)

# Process each node
for node in $WORKER_NODES; do
    ((count++))
    echo "------------------------------------------------"
    echo "Processing node $count of $total: $node"
    echo "------------------------------------------------"

    # Drain the node
    echo "Draining node: $node"
    kubectl drain "$node" --ignore-daemonsets --delete-emptydir-data --force

    if [ $? -eq 0 ]; then
        echo "Successfully drained $node"
    else
        echo "Error draining $node - continuing with next node"
    fi

    # Optional: Add a small delay between nodes
    sleep 5
done

echo "------------------------------------------------"
echo "Completed draining $count nodes"
echo "------------------------------------------------"