#!/bin/bash
# Script to SSH into machine and shut it down

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
REMOTE_HOST="operator.octal.castlenet.local"
REMOTE_PORT="22"

shutdown_node "$REMOTE_USER" "$REMOTE_HOST" "$REMOTE_PORT"


