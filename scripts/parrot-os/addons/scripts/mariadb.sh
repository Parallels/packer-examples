#!/bin/sh -eux

install() {
  echo "Installing MariaDB"
  sudo apt-get update
  sudo apt-get -y install mariadb-server
  sudo systemctl start mariadb
  sudo systemctl enable mariadb
}

# Starting script
install