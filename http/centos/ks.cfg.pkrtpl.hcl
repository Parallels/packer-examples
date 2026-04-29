#kickstart# Use text mode for efficiency during Packer builds
text
# Use the network mirror as the installation source
url --url="http://mirror.stream.centos.org/10-stream/BaseOS/aarch64/os/"
repo --name="AppStream" --baseurl="http://mirror.stream.centos.org/10-stream/AppStream/aarch64/os/"
lang en_US.UTF-8
keyboard us
timezone UTC --utc
# Account Configuration
rootpw --plaintext ${password}
user --name=${username} --plaintext --password ${password} --groups=wheel
# Bootloader & Partitioning for Apple Silicon/Parallels (UEFI)
bootloader --timeout=1 --append="console=tty0"
zerombr
clearpart --all --initlabel
# EFI partitioning requirements
part /boot/efi --fstype="efi" --size=600
part /boot --fstype="ext4" --size=1024
part / --fstype="ext4" --grow --size=1
# Network & Services
network --bootproto=dhcp --device=link --activate --onboot=on
firewall --enabled --ssh
selinux --permissive
firstboot --disable
services --enabled="sshd"
reboot --eject
%packages --ignoremissing --excludedocs
${package}
@core
openssh-server
openssh-clients
sudo
chrony
tar
wget
rsync
dnf-plugins-core
%end
%post
# Configure passwordless sudo for the primary user
echo "${username} ALL=(ALL) NOPASSWD: ALL" > /etc/sudoers.d/${username}
chmod 440 /etc/sudoers.d/${username}
#Time Sync Fix
systemctl enable chronyd
echo "server pool.ntp.org iburst" >> /etc/chrony.conf
systemctl start chronyd
hwclock --systohc --utc
echo "${hostname}" > /etc/hostname
hostnamectl set-hostname ${hostname}
%end