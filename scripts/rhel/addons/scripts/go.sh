#!/bin/sh -eux

install() {
  echo "Installing Golang"
  sudo dnf -y update
  sudo dnf -y install golang
  go version
}

# Starting script
install