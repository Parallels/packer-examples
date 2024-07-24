#!/bin/sh -eux

install() {
  echo "Installing Ansible"
  sudo dnf install -y ansible-core
  ansible --version
}

# Starting script
install
