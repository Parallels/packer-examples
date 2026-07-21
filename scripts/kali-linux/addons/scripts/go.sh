#!/bin/sh -eux

install() {
  echo "Installing Golang"
  sudo apt-get update
  sudo apt-get -y install curl git
  sudo apt install gccgo-go
  go version
}

# Starting script
install