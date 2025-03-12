#!/bin/bash
# nodes should be up, ensure are completely ready

WORKER_NODES=$(./k8s.worker.nodes.sh)

count=0
total=$(echo "$WORKER_NODES" | wc -l)

# Process each node
for node in $WORKER_NODES; do
    ((count++))
    echo "------------------------------------------------"
    echo "Processing node $count of $total: $node"
    echo "------------------------------------------------"

    # Drain the node
    echo "Uncordon node: $node"
    kubectl uncordon "$node"

    if [ $? -eq 0 ]; then
        echo "Successfully uncordoned $node"
    else
        echo "Error uncordoning $node - continuing with next node"
    fi

    # Optional: Add a small delay between nodes
    sleep 2
done

echo "------------------------------------------------"
echo "Completed bringing up $count nodes"
echo "------------------------------------------------"

echo "Cluster Status"
./k8s.cluster.status.sh
