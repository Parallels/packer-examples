#!/bin/sh -eux

install() {
  echo "Installing Debian Desktop"
  
  # Ensure package list is fresh
  sudo apt-get update
  
  # Debian uses 'task-gnome-desktop' instead of 'ubuntu-desktop'
  # We use 'gdm3' as the display manager instead of 'lightdm' for better compatibility
  sudo DEBIAN_FRONTEND=noninteractive apt-get install -y task-gnome-desktop gdm3
  
  # Enable the display manager
  sudo systemctl enable gdm3

  # Snap is not pre-installed on Debian. 
  # If you really need the Snap Store, you must install snapd first.
  if ! command -v snap >/dev/null 2>&1; then
      echo "Snap not found. Installing snapd..."
      sudo apt-get install -y snapd
      # On Debian, you need to enable the snapd service
      sudo systemctl enable --now snapd.socket
  fi

  # Attempt snap-store installation only if snap is available
  sudo snap install snap-store || echo "Snap store installation failed, moving on..."
}

# Starting script
install