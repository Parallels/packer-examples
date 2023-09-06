#!/bin/sh -eux

install() {
  echo "Installing Sublime Text"
  sudo rpm -v --import https://download.sublimetext.com/sublimehq-rpm-pub.gpg 
echo @'[sublime-text]
name=Sublime Text - x86_64
baseurl=https://download.sublimetext.com/rpm/stable/x86_64
enabled=1
gpgcheck=1
gpgkey=https://download.sublimetext.com/sublimehq-rpm-pub.gpg
  sudo systemctl enable docker
  sudo systemctl start docker
  sudo  usermod -aG docker $DEFAULT_USERNAME
}' > /etc/yum.repos.d/sublime-text.repo
  sudo dnf install sublime-text -y
}

# Starting script
install