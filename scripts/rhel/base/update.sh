#!/bin/bash -eux

# update all the packages
dnf -y upgrade --skip-broken

reboot;
sleep 60;
