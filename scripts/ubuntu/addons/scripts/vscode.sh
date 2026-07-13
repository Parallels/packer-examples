#!/bin/sh -eux

install() {
    echo "Installing Visual Studio Code"
    
    # Install dependencies
    sudo DEBIAN_FRONTEND=noninteractive apt-get install -y wget gpg
    
    # Download and install Microsoft's GPG key
    wget -qO- https://packages.microsoft.com/keys/microsoft.asc | sudo gpg --dearmor -o /usr/share/keyrings/packages.microsoft.gpg
    
    # Add the VS Code repository (ARM64) with signed-by
    echo "deb [arch=arm64 signed-by=/usr/share/keyrings/packages.microsoft.gpg] https://packages.microsoft.com/repos/code stable main" | sudo tee /etc/apt/sources.list.d/vscode.list
    
    # Update and install VS Code
    sudo apt update
    sudo DEBIAN_FRONTEND=noninteractive apt install -y code
    sudo DEBIAN_FRONTEND=noninteractive apt autoremove -y
    
    # Verify installation
    code --version
}

# Starting script
install