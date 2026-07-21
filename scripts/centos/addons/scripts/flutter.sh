#!/bin/bash
HOME_DIR="${HOME_DIR:-/home/$DEFAULT_USERNAME: -$USER}"

install() {
  # Install required dependencies
  sudo dnf update -y
  sudo dnf install -y which git wget unzip xz tar curl 

  cd $HOME_DIR

  echo "cloning Flutter stable channel"
  git clone -b stable https://github.com/flutter/flutter.git "$HOME_DIR/flutter"

  echo "Adding Flutter to PATH"
  echo "export PATH=\"\$PATH:$HOME_DIR/flutter/bin\"" >> "$HOME_DIR/.bashrc"
  source "$HOME_DIR/.bashrc"

  "$HOME_DIR/flutter/bin/flutter" doctor
  # Download and extract Flutter SDK
  LATEST=$(curl -s https://storage.googleapis.com/flutter_infra/releases/releases_linux.json | jq -r ' [.releases[]] | select(.channel=="stable")[0].version')
  echo "Downloading Flutter SDK version $LATEST"
  wget https://storage.googleapis.com/flutter_infra/releases/stable/linux/flutter_linux_$LATEST-stable.tar.xz
  echo "Extracting Flutter SDK"
  tar xf flutter_linux_$LATEST-stable.tar.xz
  rm flutter_linux_$LATEST-stable.tar.xz

  echo "Adding Flutter to PATH"
  # Add Flutter to PATH
  echo "export PATH=\"\$PATH:$HOME_DIR/flutter/bin\"" >> "$HOME_DIR/.bashrc
  source $HOME_DIR/.bashrc

  # Run Flutter doctor to verify installation
  flutter doctor
}

install
