#!/bin/bash
set -e
 
echo "==> Installing GNOME Desktop Environment..."
sudo dnf install -y @gnome-desktop --nogpgcheck

echo "==> Setting default boot target to graphical..."
sudo systemctl set-default graphical.target