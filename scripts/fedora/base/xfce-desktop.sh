#!/bin/sh -eux

dnf -y group install "Basic Desktop" xfce-desktop
systemctl set-default graphical.target