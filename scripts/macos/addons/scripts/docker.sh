#!/bin/sh -eux

install() {
  echo "Installing Docker"
  /opt/homebrew/bin/brew install --cask docker
}

# Starting script
install