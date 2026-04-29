#!/bin/sh -eux

install() {
  echo "Installing Podman"
  sudo dnf update
  sudo dnf -y install podman
  podman version
}

# Starting script
install