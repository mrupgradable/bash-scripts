#!/bin/bash
# port forwarding to k8s cluster service + namespace

kubectl -n argocd port-forward svc/argocd-server 8443:443
