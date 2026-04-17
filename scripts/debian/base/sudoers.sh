#!/bin/sh -eux

#Enable the whitelist (Removed exempt_group as sudo-rs doesn't support it)
sed -i -e '/Defaults\s\+env_reset/a Defaults\tenv_keep+="USERNAME HOME_DIR PACKER_BUILDER_TYPE ADDONS"' /etc/sudoers

#Get the username safely
REAL_USER=${USERNAME:-$(whoami)}

# Set up password-less sudo
echo "$REAL_USER ALL=(ALL) NOPASSWD:ALL" > "/etc/sudoers.d/99_$REAL_USER"
chmod 440 "/etc/sudoers.d/99_$REAL_USER"