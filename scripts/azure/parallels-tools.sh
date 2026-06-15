#!/bin/bash -eux

# 1. REFRESH METADATA 
sudo tdnf makecache


# 2. Ensure the built-in modules are active:
sudo modprobe loop || true
sudo modprobe isofs || true

# 3. CREATE MOUNT POINT
sudo mkdir -p /mnt/parallels


# 4. MOUNT THE ISO
attached_cd=$(ls /dev/disk/by-id/ | grep DVD-ROM__2)
sudo mount /dev/disk/by-id/$attached_cd /mnt/parallels


# 5. RUN THE PARALLELS INSTALLER
sudo /mnt/parallels/install --install-unattended-with-deps

# 6. CLEANUP
sudo umount /mnt/parallels
sudo rm -rf /mnt/parallels
