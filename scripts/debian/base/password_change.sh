#!/bin/sh -eux

REAL_USER=${USERNAME:-$(whoami)}

echo "Changing password settings for: $REAL_USER"
passwd -d "$REAL_USER"
passwd --expire "$REAL_USER"

echo "Cleaning up sudoers environment configuration..."
sed -i '/Defaults\tenv_keep+="USERNAME HOME_DIR PACKER_BUILDER_TYPE ADDONS"/d' /etc/sudoers
shutdown -P +1
