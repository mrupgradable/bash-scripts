#!/bin/bash
# take down k8s nodes (starting with workers, then master)

echo "Draining WORKER nodes.."
#./k8s.drain.worker.nodes.sh

echo "Waiting..."
#sleep 2

echo "Cluster Status"
#./k8s.cluster.status.sh

echo "Shutting down nodes..."
./k8s.remote.shutdown.sh
