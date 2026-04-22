# Fedora 42 Server - ARM64 Unattended Kickstart
lang en_US.UTF-8
keyboard us
timezone UTC --utc
text
cdrom
 
# Account Configuration
rootpw --plaintext ${password}
user --name=${username} --plaintext --password ${password} --groups=wheel
 
# Bootloader & Partitioning for Apple Silicon/Parallels (UEFI)
bootloader --timeout=1 --append="net.ifnames=0 biosdevname=0 console=tty0"
zerombr
clearpart --all --initlabel
 
# EFI partitioning requirements
part /boot/efi --fstype="efi" --size=600
part /boot --fstype="ext4" --size=1024
part / --fstype="ext4" --grow --size=1
 
# Network & Services
network --bootproto=dhcp --device=link --activate --onboot=on --hostname=${hostname}
firewall --enabled --ssh
selinux --permissive
firstboot --disable
services --enabled="sshd"
reboot --eject
 
%packages --ignoremissing --excludedocs
${package}
@core
openssh-clients
sudo
wget
rsync
dnf-plugins-core
%end
 
%post
# Configure passwordless sudo for the primary user
echo "${username} ALL=(ALL) NOPASSWD: ALL" > /etc/sudoers.d/${username}
chmod 440 /etc/sudoers.d/${username}
%end