#!/bin/sh -eux

install() {
    echo "Installing Flutter"
    
    #Install required dependencies
    sudo dnf update -y
    sudo dnf install -y which git wget unzip xz tar curl
    
    #Go to user's home directory
    cd $HOME
    
    #Remove any existing Flutter installation
    sudo rm -rf flutter
    
    #Clone Flutter from GitHub (ARM64 compatible)
    git clone https://github.com/flutter/flutter.git -b stable
    
    #Add Flutter to PATH
    echo "export PATH=\"\$PATH:$HOME/flutter/bin\"" >> $HOME/.bashrc
    export PATH="$PATH:$HOME/flutter/bin"
    
    #Run Flutter doctor to verify installation
    flutter doctor
}

#Starting script
install