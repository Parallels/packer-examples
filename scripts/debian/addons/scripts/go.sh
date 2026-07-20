#!/bin/sh -eux

install() {
  echo "Installing Go"

  #update package lists

  sudo apt-get update

  #install Go from Debian repositories (ARM64 compatible)

  sudo apt-get install -y golang-go

  #verify installation

  go version
  
}

#Starting script
install
