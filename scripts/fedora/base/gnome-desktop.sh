#!/bin/sh -eux

dnf -y group install "Basic Desktop" gnome
systemctl set-default graphical.target