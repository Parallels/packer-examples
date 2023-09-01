# This file replaces preseed.cfg embedded in the initrd by
# debian-installer. It should be kept in sync except with the
# mirror/{codename,suite} dropped so that the image installs
# what's available on the CD instead of hardcoding a specific
# release.

# Default repository information (don't include codename data, d-i figures it
# out from what's available in the ISO)
d-i mirror/country string enter information manually
d-i mirror/http/hostname string deb.parrot.sh
d-i mirror/http/directory string /parrot/

# Disable security, updates and backports
d-i apt-setup/services-select multiselect 

# Enable contrib and non-free
d-i apt-setup/non-free boolean true
d-i apt-setup/contrib boolean true

# Disable CDROM entries after install
d-i apt-setup/disable-cdrom-entries boolean true

# Disable source repositories too
d-i apt-setup/enable-source-repositories boolean false

# Upgrade installed packages
d-i pkgsel/upgrade select full-upgrade

# Change default hostname
# DISABLED: We take care of this by forking netcfg until #719101 is fixed
# d-i netcfg/get_hostname string kali
# d-i netcfg/get_hostname seen false

# Disable the root user entirely
d-i passwd/root-login boolean false

# Enable eatmydata in kali-installer to boost speed installation
d-i preseed/early_command string anna-install eatmydata-udeb

# Disable question about automatic security updates
d-i pkgsel/update-policy select none

# Disable question about extra media
d-i apt-setup/cdrom/set-first boolean false

## Questions from regular packages

# Disable popularity-contest
popularity-contest popularity-contest/participate boolean false

# Random other questions
console-setup console-setup/charmap47 select UTF-8
samba-common samba-common/dhcp boolean false
macchanger macchanger/automatically_run boolean false
kismet-capture-common kismet-capture-common/install-users string 
kismet-capture-common kismet-capture-common/install-setuid boolean true
wireshark-common wireshark-common/install-setuid boolean true
sslh sslh/inetd_or_standalone select standalone
atftpd atftpd/use_inetd boolean false

################################
# Custom preseed configuration #
################################

# Network
d-i netcfg/get_hostname string ${hostname}
d-i netcfg/get_domain string unassigned-domain
d-i netcfg/choose_interface select eth0
d-i netcfg/dhcp_timeout string 60

# Locale
d-i debian-installer/language string en
d-i debian-installer/country string US
d-i debian-installer/locale string en_US.UTF-8

# Keyboard selection.
d-i keyboard-configuration/xkb-keymap select us
d-i keymap select us

### Clock and time zone setup
d-i clock-setup/utc boolean true
d-i clock-setup/utc-auto boolean true
d-i time/zone string UTC

# Don't ask for proxy settings
d-i mirror/http/proxy string

# Partitioning
d-i partman-efi/non_efi_system boolean true
d-i partman-auto-lvm/guided_size string max
d-i partman-auto/choose_recipe select atomic
d-i partman-auto/method string lvm
d-i partman-lvm/confirm boolean true
d-i partman-lvm/confirm_nooverwrite boolean true
d-i partman-lvm/device_remove_lvm boolean true
d-i partman/choose_partition select finish
d-i partman/confirm boolean true
d-i partman/confirm_nooverwrite boolean true
d-i partman/confirm_write_new_label boolean true
d-i partman-basicfilesystems/no_swap boolean false

# Packages
tasksel tasksel/first multiselect ${desktop} parrot parrot-tools-full
d-i pkgsel/include string \
    curl git base-files 

# Grub
d-i grub-installer/only_debian boolean true
d-i grub-installer/with_other_os boolean false
d-i grub-installer/bootdev string /dev/sda

### Account setup
d-i passwd/root-login boolean false
d-i passwd/user-fullname string ${username}
d-i passwd/user-uid string 1000
d-i passwd/user-password password ${password}
d-i passwd/user-password-again password ${password}
d-i passwd/username string ${username}

# The installer will warn about weak passwords. If you are sure you know
# what you're doing and want to override it, uncomment this.
d-i user-setup/allow-password-weak boolean true
d-i user-setup/encrypt-home boolean false

# Automatically reboot after installation
d-i finish-install/reboot_in_progress note

# Eject media after installation
d-i cdrom-detect/eject boolean true

# Post-install commands
d-i preseed/late_command string \
    in-target curl -L -o /root/post-install.sh "https://raw.githubusercontent.com/Parallels/packer-examples/main/http/kali/post-install.sh"; \
    in-target chmod +x /root/post-install.sh; \
    in-target /root/post-install.sh; \
    echo "${username} ALL=(ALL:ALL) NOPASSWD:ALL" > /target/etc/sudoers.d/${username} && chmod 0440 /target/etc/sudoers.d/${username}