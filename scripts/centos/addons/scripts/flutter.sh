 #!/bin/sh -eux
HOME_DIR="${HOME_DIR:-/home/$DEFAULT_USERNAME}"

install() {
 


    echo "Installing Flutter on CentOS ARM64"
    
   
    sudo dnf update -y
    sudo dnf install -y which git wget unzip xz tar curl
    
    
    cd $HOME
    
  
    sudo rm -rf flutter
    
   
    git clone https://github.com/flutter/flutter.git -b stable
    
    
    echo "export PATH=\"\$PATH:$HOME/flutter/bin\"" >> $HOME/.bashrc
    export PATH="$PATH:$HOME/flutter/bin"
    
   
    flutter doctor


}

install
