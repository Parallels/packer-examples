#!/bin/sh -eux

dnf install @budgie-desktop -y
systemctl set-default graphical.target
systemctl enable gdm.service