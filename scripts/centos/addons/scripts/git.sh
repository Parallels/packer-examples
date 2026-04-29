#!/bin/sh -eux

install() {
  echo "Installing Git"
  sudo dnf update
  sudo dnf -y install git
}

# Starting script
install