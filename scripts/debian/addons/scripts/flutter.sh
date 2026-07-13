#!/bin/sh -eux
#!/bin/sh -eux

install() {
    echo "Installing Flutter"
    #Update package lists
    sudo apt-get update
    #Install Flutter dependencies
    sudo apt-get install -y curl git unzip xz-utils zip libglu1-mesa clang cmake ninja-build pkg-config
    #Remove any existing Flutter installation
    sudo rm -rf /opt/flutter
    #Clone Flutter from source (ARM64 compatible)
    sudo git clone https://github.com/flutter/flutter.git -b stable /opt/flutter
    #Fix permissions so user can run Flutter
    sudo chown -R $USER:$USER /opt/flutter
    #Add Flutter to PATH
    export PATH="$PATH:/opt/flutter/bin"
    echo 'export PATH="$PATH:/opt/flutter/bin"' >> ~/.bashrc
    #Run Flutter doctor to set up dependencies
    flutter doctor
    #Show Flutter version ()
    flutter --version
}

#Starting script (flutter 3.29.0)
install