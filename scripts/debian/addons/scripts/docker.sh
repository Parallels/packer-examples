#!/bin/sh -eux


install() {
    echo "Installing Docker"
    
    #Remove any existing Docker repo files (to prevent malformed entry)
    sudo rm -f /etc/apt/sources.list.d/docker.list
    
    #Install Docker using the official script
    curl -fsSL https://get.docker.com | sh
    
    #Add user to docker group
    sudo usermod -aG docker $USER
    
    #Verify installation
    docker --version
}

#Starting script (docker 29.6.1)
install
