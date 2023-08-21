#!/bin/sh -eux

install() {
  echo "Installing Flutter"
  sudo apt-get update
  sudo apt-get -y install curl git unzip xz-utils zip libglu1-mesa
  sudo snap install flutter --classic
  sudo -u $USERNAME flutter doctor
  sudo -u $USERNAME flutter --version
}

# Starting script
install