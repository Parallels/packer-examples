#!/bin/sh -eux

sudo apt install snap snapd -y
sudo apt --fix-broken install
sudo systemctl enable snapd
sudo systemctl enable apparmor
sudo systemctl start snapd
sudo systemctl start apparmor
sudo systemctl enable snapd.socket snapd apparmor
sudo systemctl start snapd.socket snapd apparmor