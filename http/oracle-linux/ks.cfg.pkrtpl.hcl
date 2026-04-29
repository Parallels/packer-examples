lang en_US.UTF-8
keyboard us
timezone UTC --utc
text
cdrom
 
# Account Configuration
rootpw --plaintext ${password}
user --name=${username} --plaintext --password ${password} --groups=wheel
 
# Bootloader & Partitioning for Apple Silicon/Parallels (UEFI)
bootloader --timeout=1 --append="net.ifnames=0 biosdevname=0 console=tty0 drm.edid_firmware=edid/1280x800.bin"
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
tar
bzip2
make
kernel-devel
%end
%post --erroronfail
echo "${username} ALL=(ALL) NOPASSWD: ALL" > /etc/sudoers.d/${username}
echo "Defaults:${username} !requiretty" >> /etc/sudoers.d/${username}
chmod 440 /etc/sudoers.d/${username}
sed -i 's/^SELINUX=.*/SELINUX=permissive/' /etc/selinux/config
mkdir -p /etc/NetworkManager/system-connections/
cat > /etc/NetworkManager/system-connections/eth0.nmconnection << _EOF_
[connection]
id=eth0
type=ethernet
interface-name=eth0

[ethernet]

[ipv4]
method=auto

[ipv6]
method=auto
addr-gen-mode=stable-privacy
_EOF_

chmod 600 /etc/NetworkManager/system-connections/eth0.nmconnection
%end