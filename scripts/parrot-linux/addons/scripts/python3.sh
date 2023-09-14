#!/bin/sh -eux

install() {
  echo "Installing Python"
  sudo apt-get update
  sudo apt-get -y install python3 python3-pip
}

# Starting script
install