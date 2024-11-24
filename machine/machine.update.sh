#!/bin/bash
# machine upgrade script

echo -e "\nUpgrading machine..."

echo -e "\nUsing APT to update packages..."

sudo apt update
sudp apt upgrade
sudo apt autoclean
sudo apt autoremove

echo -e "\nUsing SNAP to update snaps..."

sudo snap refresh --list
sudo snap refresh

echo -e "\nUpgrading machine DONE"
