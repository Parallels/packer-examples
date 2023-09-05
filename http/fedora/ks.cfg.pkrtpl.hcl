lang en_US.UTF-8
keyboard --xlayouts='us'
network --bootproto=dhcp --noipv6 --onboot=on --device=eth0
rootpw --plaintext ${username}
firewall --disabled
selinux --permissive
timezone UTC
bootloader --timeout=1 --location=mbr --append="net.ifnames=0 biosdevname=0"
text
skipx
zerombr
clearpart --all --initlabel
autopart --nohome --nolvm --noboot
firstboot --disabled
reboot --eject
user --name=${username} --plaintext --password ${password}

%packages --ignoremissing --excludedocs
bzip2
tar
wget
nfs-utils
net-tools
rsync
dkms
-plymouth
-plymouth-core-libs
-fedora-release-notes
-mcelog
-smartmontools
-usbutils
-microcode_ctl
%end


%post
# sudo
echo 'Defaults:${username} !requiretty' > /etc/sudoers.d/${username}
echo '%${username} ALL=(ALL) NOPASSWD: ALL' >> /etc/sudoers.d/${username}
chmod 440 /etc/sudoers.d/${username}
%end