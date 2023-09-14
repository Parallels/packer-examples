#!/bin/sh -eux

install() {
  echo "Installing Golang"
  sudo apt-get update
  sudo apt-get -y install curl git
  sudo snap install go --classic
  go version
}

# Starting script
install