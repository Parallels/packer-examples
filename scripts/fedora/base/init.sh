#!/bin/bash -eux
# Installing build tools here because Fedora 22+ will not do so during kickstart
dnf -y install kernel-headers kernel-devel-"$(uname -r)" elfutils-libelf-devel gcc make perl libxcrypt-compat

echo "Don't use the tmpfs based /tmp dir that is limited to 50% of RAM"
systemctl mask tmp.mount

# update all the packages
dnf -y upgrade

reboot;
sleep 60;