#!/bin/bash
# Script to SSH into multiple machines and shut them down
# USAGE:
#   Default user (ubuntu)
#   ./k8s.remote.shutdown.sh node1.example.com node2.example.com:22
#
#   Custom user
#   ./k8s.remote.shutdown.sh node1.example.com node2.example.com:22 myuser
#
#   Mixed format
#   ./k8s.remote.shutdown.sh user1@node1 node2:22 myuser

# Function to shutdown a single node
shutdown_node() {
    local USERNAME=$1
    local HOSTNAME=$2
    local PORT=${3:-22}  # Default to port 22 if not specified

    echo "------------------------------------------------"
    echo "Attempting to shutdown $USERNAME@$HOSTNAME on port $PORT..."

    # SSH and execute shutdown command
    ssh -p "$PORT" "$USERNAME@$HOSTNAME" "sudo shutdown -h now"

    # Check SSH exit status
    if [ $? -eq 0 ]; then
        echo "Successfully initiated shutdown on $HOSTNAME"
    else
        echo "Failed to connect or execute shutdown on $HOSTNAME"
        echo "Possible issues: authentication failure, network error, or insufficient permissions"
        return 1
    fi
    echo "------------------------------------------------"
}

# Check if ssh is installed
if ! command -v ssh &> /dev/null; then
    echo "Error: ssh is not installed or not in PATH"
    exit 1
fi

# Default remote user
REMOTE_USER="ubuntu"

# NODES from remaining arguments or default example
if [ $# -gt 0 ]; then
    NODES="$*"
else
    # todo: using local dir (future should be everywhere)
    NODES=$(./k8s.node.hosts.list.sh)
    echo "nodes! ${NODES}"
    echo "No nodes specified, using default k8s nodes: $NODES"
fi

# Check if NODES is empty
if [ -z "$NODES" ]; then
    echo "Error: NODES variable is empty or not set"
    echo "Usage: $0 <node1> [node2 ...] [remote_user]"
    echo "Example: $0 node1 node2:22 customuser"
    exit 1
fi

# Read & reverse all nodes
REMOTE_NODES=$(echo "$NODES" | tr ' ' '\n' | tac | tr '\n' ' ')

echo "Will shutdown in this order ⇒ $REMOTE_NODES"

# Counter for processed nodes
count=0
total=$(echo "$NODES" | wc -w)

echo "Starting shutdown process for $total nodes with user $REMOTE_USER..."

# Loop through each node
for node in $REMOTE_NODES; do
    ((count++))
    echo "Processing node $count of $total"

    # Parse node string (format: host:port or host, or user@host:port)
    if [[ "$node" =~ @ ]]; then
        # If node contains username, use it instead of REMOTE_USER
        IFS='@' read -r username hostname_port <<< "$node"
    else
        username="$REMOTE_USER"
        hostname_port="$node"
    fi

    IFS=':' read -r hostname port <<< "$hostname_port"

    # If no port specified, shutdown_node function will use default (22)
    shutdown_node "$username" "$hostname" "$port"

    # Optional: Add delay between shutdowns
    sleep 2
done

echo "------------------------------------------------"
echo "Completed shutdown process for $count nodes"
echo "------------------------------------------------"