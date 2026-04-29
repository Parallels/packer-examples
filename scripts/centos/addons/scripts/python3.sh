#!/bin/sh -eux

install() {
  echo "Installing Python"
  sudo dnf update
  sudo dnf -y install python3 python3-pip
}

# Starting script
install