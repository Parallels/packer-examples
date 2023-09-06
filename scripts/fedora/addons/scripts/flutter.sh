#!/bin/bash
HOME_DIR="${HOME_DIR:-/home/$DEFAULT_USERNAME}";

# Install required dependencies
sudo dnf update -y
sudo dnf install -y which git wget unzip xz tar lib32stdc++6 culr

cd /usr/local
# Download and extract Flutter SDK
LATEST=$(curl -s https://storage.googleapis.com/flutter_infra/releases/releases_linux.json | grep version | grep -v dev | grep -v beta | grep -v rc | head -n 1 | cut -d '"' -f 4)
cd ~
wget https://storage.googleapis.com/flutter_infra/releases/stable/linux/flutter_linux_$LATEST-stable.tar.xz
tar xf flutter_linux_$LATEST-stable.tar.xz
rm flutter_linux_$LATEST-stable.tar.xz

# Add Flutter to PATH
echo 'export PATH="$PATH:/usr/local/flutter/bin"' >> $HOME_DIR/.bashrc
source $HOME_DIR/.bashrc

# Run Flutter doctor to verify installation
flutter doctor
