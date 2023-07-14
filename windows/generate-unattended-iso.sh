#!/bin/bash

if [ -f "unattended.iso" ]; then
  echo "Removing old unattended.iso..."
  rm unattended.iso
fi

echo "Creating unattended.iso..."
hdiutil makehybrid -iso -joliet -o unattended.iso ../scripts/windows/answer_files
echo "unattended.iso created!"
exit 0
