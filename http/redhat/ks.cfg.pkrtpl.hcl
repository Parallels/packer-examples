lang en_US.UTF-8
keyboard us
timezone UTC
rootpw --plaintext ${username}
reboot --eject
cdrom
bootloader --timeout=1 --location=mbr --append="net.ifnames=0 biosdevname=0"
zerombr
clearpart --all --initlabel
autopart --nohome --nolvm --noboot
network --bootproto=dhcp
firstboot --disable
selinux --permissive
firewall --enabled --ssh
user --name=${username} --plaintext --password ${password}

%packages --ignoremissing --excludedocs
${package}
openssh-clients
sudo
selinux-policy-devel
wget
nfs-utils
net-tools
tar
bzip2
deltarpm
rsync
dnf-utils
redhat-lsb-core
elfutils-libelf-devel
network-scripts
-fprintd-pam
-intltool
-iwl*-firmware
-microcode_ctl
%end

%post
# sudo
echo 'Defaults:${username} !requiretty' > /etc/sudoers.d/${username}
echo '%${username} ALL=(ALL) NOPASSWD: ALL' >> /etc/sudoers.d/${username}
chmod 440 /etc/sudoers.d/${username}

rm -f /etc/sysconfig/network-scripts/ifcfg-e*
cat > /etc/sysconfig/network-scripts/ifcfg-eth0 << _EOF_
TYPE=Ethernet
PROXY_METHOD=none
             BROWSER_ONLY=no
             BOOTPROTO=dhcp
             DEFROUTE=yes
IPV4_FAILURE_FATAL=no
IPV6INIT=yes
IPV6_AUTOCONF=yes
IPV6_DEFROUTE=yes
             IPV6_FAILURE_FATAL=no
             IPV6_ADDR_GEN_MODE=stable-privacy
             NAME=eth0
DEVICE=eth0
ONBOOT=yes
_EOF_
%end