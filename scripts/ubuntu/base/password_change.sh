#!/bin/sh -eux

passwd -d $USERNAME
passwd --expire $USERNAME
