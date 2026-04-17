#!/bin/sh -eux

install() {
  echo "Installing Git"
  sudo apt-get update
  sudo apt-get -y install git
}

# Starting script
install