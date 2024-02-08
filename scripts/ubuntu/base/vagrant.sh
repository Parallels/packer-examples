#!/bin/sh -eux

# set a default HOME_DIR environment variable if not set
HOME_DIR="${HOME_DIR:-/home/$USERNAME}"
pubkey_url="https://raw.githubusercontent.com/hashicorp/vagrant/main/keys/vagrant.pub"
mkdir -p "$HOME_DIR"/.ssh
if command -v wget >/dev/null 2>&1; then
  echo "Downloading vagrant public key using wget: $pubkey_url" >> /tmp/vagrant-install.log
  wget --no-check-certificate "$pubkey_url" -O "$HOME_DIR"/.ssh/authorized_keys
elif command -v curl >/dev/null 2>&1; then
  echo "Downloading vagrant public key using curl: $pubkey_url" >> /tmp/vagrant-install.log
  curl --insecure --location "$pubkey_url" >"$HOME_DIR"/.ssh/authorized_keys
elif command -v fetch >/dev/null 2>&1; then
  echo "Downloading vagrant public key using fetch: $pubkey_url" >> /tmp/vagrant-install.log
  fetch -am -o "$HOME_DIR"/.ssh/authorized_keys "$pubkey_url"
else
  echo "Cannot download vagrant public key" >> /tmp/vagrant-install.log
  echo "Cannot download vagrant public key"
  exit 1
fi

wget --no-check-certificate "$pubkey_url" -O "$HOME_DIR"/authorized_keys

chown -R $USERNAME "$HOME_DIR"/.ssh
chmod -R go-rwsx "$HOME_DIR"/.ssh
