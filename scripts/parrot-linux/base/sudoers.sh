#!/bin/sh -eux

sudo sed -i -e '/Defaults\s\+env_reset/a Defaults\texempt_group=sudo' /etc/sudoers;

# Set up password-less sudo for the ubuntu user
echo "$DEFAULT_USERNAME ALL=(ALL) NOPASSWD:ALL" >/etc/sudoers.d/99_$DEFAULT_USERNAME;
sudo chmod 440 /etc/sudoers.d/99_$DEFAULT_USERNAME;
