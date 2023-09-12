#!/bin/sh -eux

install() {
  echo "Installing Podman"
  sudo apt-get update
  sudo apt-get -y install podman
  podman version
}

# Starting script
install