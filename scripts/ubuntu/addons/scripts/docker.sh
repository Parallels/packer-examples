#!/bin/sh -eux

install() {
  echo "Installing Docker"
  sudo  apt-get update
  sudo  apt-get -y install ca-certificates curl gnupg
  sudo  install -m 0755 -d /etc/apt/keyrings
  echo "Downloading Docker's official GPG key"
  curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo  gpg --dearmor -o /etc/apt/keyrings/docker.gpg
  sudo  chmod a+r /etc/apt/keyrings/docker.gpg
  echo \
    "deb [arch="$(dpkg --print-architecture)" signed-by=/etc/apt/keyrings/docker.gpg] https://download.docker.com/linux/ubuntu \
    "$(. /etc/os-release && echo "$VERSION_CODENAME")" stable" | \
    sudo  tee /etc/apt/sources.list.d/docker.list > /dev/null
  sudo  apt-get update
  sudo  apt-get -y install docker-ce docker-ce-cli containerd.io docker-buildx-plugin docker-compose-plugin
  sudo systemctl enable docker
  sudo systemctl start docker
  sudo  usermod -aG docker $USERNAME
}

# Starting script
install