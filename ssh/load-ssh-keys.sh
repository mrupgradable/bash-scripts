#!/bin/bash
# load ssh keys

echo "\nGet your password manager ready..."
read -r -n1 key 

echo -e "\nload senary key"
ssh-add ~/.ssh/mrupgradable-senary


echo -e "\nload senary server key"
ssh-add ~/.ssh/mrupgradable_server_ssh

echo -e "\nlisting keys"
ssh-add -l
