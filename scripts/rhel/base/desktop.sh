#!/bin/sh -eux

dnf -y install @graphical-server-environment
systemctl set-default graphical.target