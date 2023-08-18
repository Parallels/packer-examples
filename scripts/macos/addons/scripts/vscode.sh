#!/bin/sh -eux

install() {
  echo "Installing Visual Studio Code"

  /opt/homebrew/bin/brew install --cask visual-studio-code
}

# Starting script
install
