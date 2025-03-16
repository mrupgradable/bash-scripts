#!/bin/bash
# port forwarding to k8s cluster service + namespace

echo "k port-forward service/$1 7379:6379 -n $2" | xclip -selection clipboard

