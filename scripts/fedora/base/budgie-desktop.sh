#!/bin/sh -eux

dnf -y group install "Basic Desktop" budgie-desktop
systemctl set-default graphical.target