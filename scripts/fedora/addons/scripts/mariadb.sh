#!/bin/sh -eux

install() {
  echo "Installing MariaDB"
  sudo dnf update
  sudo dnf install mariadb-server
  sudo systemctl start mariadb
  sudo systemctl enable mariadb
}

# Starting script
install