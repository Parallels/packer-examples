#!/bin/sh -eux
export DEBIAN_FRONTEND=noninteractive

# Only disable release-upgrades if the file exists (Ubuntu specific)
if [ -f /etc/update-manager/release-upgrades ]; then
    echo "disable release-upgrades"
    sed -i.bak 's/^Prompt=.*$/Prompt=never/' /etc/update-manager/release-upgrades
fi

echo "disable systemd apt timers/services"
systemctl stop apt-daily.timer || true
systemctl stop apt-daily-upgrade.timer || true
systemctl disable apt-daily.timer || true
systemctl disable apt-daily-upgrade.timer || true
systemctl mask apt-daily.service || true
systemctl mask apt-daily-upgrade.service || true
systemctl daemon-reload || true

# Disable periodic activities of apt to be safe
cat <<EOF >/etc/apt/apt.conf.d/10periodic
APT::Periodic::Enable "0";
APT::Periodic::Update-Package-Lists "0";
APT::Periodic::Download-Upgradeable-Packages "0";
APT::Periodic::AutocleanInterval "0";
APT::Periodic::Unattended-Upgrade "0";
EOF

echo "Attempting to remove unattended-upgrades and ubuntu-release-upgrader-core"
rm -rf /var/log/unattended-upgrades
# Using '|| true' allows the script to continue if the packages aren't found on Debian
apt-get -y purge unattended-upgrades ubuntu-release-upgrader-core || true

echo "==> Attempting to sync system clock..."
hwclock --hctosys || true 
systemctl restart systemd-timesyncd || true

# Give it a moment to sync
sleep 5
date

echo "update the package list"
apt-get -y update

echo "upgrade all installed packages incl. kernel and kernel headers"
apt-get -y dist-upgrade -o Dpkg::Options::="--force-confnew"

echo "Rebooting the system to apply kernel updates..."
sync
sleep 2
# We use 'reboot' but expect Packer to handle the disconnect
reboot