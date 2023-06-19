#!/bin/sh -eux

install() {
  echo "Installing Desktop"
  sudo apt update && sudo DEBIAN_FRONTEND=noninteractive apt upgrade -y
  sudo DEBIAN_FRONTEND=noninteractive apt install -y ubuntu-desktop lightdm
  sudo snap install snap-store
  sudo reboot
}

# Starting script
install
