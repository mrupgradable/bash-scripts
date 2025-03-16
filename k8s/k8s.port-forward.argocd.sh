#!/bin/bash
# port forwarding to k8s cluster service + namespace

kubectl port-forward svc/argocd-server 8443:443 -n argocd
