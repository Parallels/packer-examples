#!/bin/sh

# The reference version of this script is maintained in
# ./live-build-config/kali-config/common/includes.installer/kali-finish-install
#
# It is used in multiple places to finish configuring the target system
# and build.sh copies it where required (in the simple-cdd configuration
# and in the live-build configuration).

configure_sources_list() {
    if grep -q '^deb http' /etc/apt/sources.list; then
	echo "INFO: sources.list is configured, everything is fine"
	return
    fi

    echo "INFO: sources.list is empty, setting up a default one for Kali"

    cat >/etc/apt/sources.list <<END
# See https://www.kali.org/docs/general-use/kali-linux-sources-list-repositories/
deb http://http.kali.org/kali kali-rolling main contrib non-free

# Additional line for source packages
# deb-src http://http.kali.org/kali kali-rolling main contrib non-free
END
    apt-get update
}

get_user_list() {
    for user in $(cd /home && ls); do
	if ! getent passwd "$user" >/dev/null; then
	    echo "WARNING: user '$user' is invalid but /home/$user exists"
	    continue
	fi
	echo "$user"
    done
    echo "root"
}

configure_zsh() {
    if grep -q 'nozsh' /proc/cmdline; then
	echo "INFO: user opted out of zsh by default"
	return
    fi
    if [ ! -x /usr/bin/zsh ]; then
	echo "INFO: /usr/bin/zsh is not available"
	return
    fi
    for user in $(get_user_list); do
	echo "INFO: changing default shell of user '$user' to zsh"
	chsh --shell /usr/bin/zsh $user
    done
}

# This is generically named in case we want to add other groups in the future.
configure_usergroups() {
    # Create the kaboxer group if needed
    addgroup --system kaboxer || true
    # Create the wireshark group if needed
    addgroup --system wireshark || true

    # adm - read access to log files
    # kaboxer - for kaboxer
    # dialout - for serial access
    # wireshark - capture sessions in wireshark
    kali_groups="adm,kaboxer,dialout,wireshark"

    for user in $(get_user_list); do
	echo "INFO: adding user '$user' to groups '$kali_groups'"
	usermod -a -G "$kali_groups" $user || true
    done
}

configure_sources_list
configure_zsh
configure_usergroups

##################################
# Custom post-installation steps #
##################################

configure_swapfile() {
    dd if=/dev/zero of=/swapfile bs=2G count=1
    chmod 600 /swapfile
    mkswap /swapfile
    printf "/swapfile none swap sw 0 0\n" >> /etc/fstab
}

configure_swapfile

install_ssh() {
    sudo apt install ssh -y
    sudo systemctl enable ssh.service
    sudo systemctl start ssh
}

install_ssh