#!/bin/sh -eux

install_service() {
  # Define the file path
  file_path="/etc/systemd/system/visual_studio_code.service"

  # Define the content to write to the file
  content="[Unit]
Description=Microsoft Visual Studio Code Server

[Service]
User=vagrant
WorkingDirectory=/home/vagrant
ExecStart=code tunnel --accept-server-license-terms
Restart=always

[Install]
WantedBy=multi-user.target"

  # Write the content to the file
  echo "$content" >"$file_path"
  sudo systemctl daemon-reload
  sudo systemctl enable visual_studio_code.service
}

install() {
  echo "Installing Visual Studio Code"

  sudo DEBIAN_FRONTEND=noninteractive apt-get install wget gpg
  wget -qO- https://packages.microsoft.com/keys/microsoft.asc | gpg --dearmor >packages.microsoft.gpg
  sudo install -D -o root -g root -m 644 packages.microsoft.gpg /etc/apt/keyrings/packages.microsoft.gpg
  sudo sh -c 'echo "deb [arch=amd64,arm64,armhf signed-by=/etc/apt/keyrings/packages.microsoft.gpg] https://packages.microsoft.com/repos/code stable main" > /etc/apt/sources.list.d/vscode.list'
  rm -f packages.microsoft.gpg
  sudo DEBIAN_FRONTEND=noninteractive apt install -y apt-transport-https
  sudo apt update
  sudo DEBIAN_FRONTEND=noninteractive apt install -y code
  sudo DEBIAN_FRONTEND=noninteractive apt autoremove -y

  echo "Installing Visual Studio Code service"
  install_service
}

# Starting script
install
