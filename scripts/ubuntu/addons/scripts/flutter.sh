#!/bin/sh -eux

install() {
  echo "Installing Flutter"
  sudo apt-get update
  sudo apt-get -y install curl git unzip xz-utils zip libglu1-mesa
  sudo snap install flutter --classic
  flutter doctor
}

# Starting script
install