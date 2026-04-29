#!/bin/sh -eux

install() {
  echo "Installing Visual Studio Code"

  sudo rpm --import https://packages.microsoft.com/keys/microsoft.asc
  cat <<EOF | sudo tee /etc/yum.repos.d/vscode.repo
[code]
name=Visual Studio Code
baseurl=https://packages.microsoft.com/yumrepos/vscode
enabled=1
gpgcheck=1
gpgkey=https://packages.microsoft.com/keys/microsoft.asc
EOF
  sudo dnf check-update
  sudo dnf -y install code
}

# Starting script
install
