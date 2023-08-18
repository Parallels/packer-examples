#!/bin/sh -eux

install() {
  echo "Installing git"
  /opt/homebrew/bin/brew install git
}

# Starting script
install