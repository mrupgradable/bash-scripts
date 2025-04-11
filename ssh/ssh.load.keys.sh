#!/bin/bash
# load ssh keys

echo -e "\nGet your password manager ready..."
read -r -n1 key 

echo -e "\nload senary key"
ssh-add ~/.ssh/mrupgradable-senary

echo -e "\nload senary server key"
ssh-add ~/.ssh/mrupgradable_server_ssh

echo -e "\nload senary cloud compute key"
ssh-add ~/.ssh/mrupgradable_cloud_compute_ssh

echo -e "\nload senary key (for castlenet)"
ssh-add ~/.ssh/mrupgradable-senary-castlenet

echo -e "\nlisting keys"
ssh-add -l
