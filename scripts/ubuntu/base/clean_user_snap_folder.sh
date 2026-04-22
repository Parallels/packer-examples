#!/bin/sh -eux

if [ -d "/home/$USERNAME/snap" ]; then
  echo "Removing snap folder from /home/$USERNAME/snap"
  rm -rf "/home/$USERNAME/snap"
fi
