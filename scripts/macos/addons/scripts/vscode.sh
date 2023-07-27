#!/bin/sh -eux

install() {
  echo "Installing Visual Studio Code"

  /opt/homebrew/bin/brew install --cask visual-studio-code

  echo "Installing Visual Studio Code service"
}

# Starting script
install
