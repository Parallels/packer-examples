#!/bin/sh -eux

install() {
  echo "Installing Docker"
  sudo  apt-get update
  sudo  apt-get -y install docker.io docker-compose
  sudo systemctl enable docker
  sudo systemctl start docker
  sudo  usermod -aG docker $DEFAULT_USERNAME
}

# Starting script
install