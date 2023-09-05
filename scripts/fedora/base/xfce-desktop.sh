#!/bin/sh -eux

dnf install @xfce-desktop -y
systemctl set-default graphical.target