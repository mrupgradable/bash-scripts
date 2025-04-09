#!/bin/bash
# port forwarding to k8s cluster dashboard

kubectl -n kubernetes-dashboard port-forward svc/kubernetes-dashboard-kong-proxy 9443:443
