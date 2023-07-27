#!/bin/bash

# Get the first argument
distro=$1

if [ "$distro" == "windows" ]; then
  folder="./$distro/addons/choco/scripts"
else
  folder="./$distro/addons/scripts"
fi

# Check if the folder exists
if [ ! -d "$folder" ]; then
  exit 0

fi

for file in $(find $folder -name "*.name"); do
# BEGIN: 5d8f5a6b3c4e
if [ -f "$file" ]; then
  name=$(basename "$file" .name)
  ext=$(echo "$file" | sed 's/.*\.//')
  if [ -n "$(find "$folder" -maxdepth 1 -type f -name "$name.*" -not -name "$name.$ext")" ]; then
      echo "$(cat "$file" | head -n 1)"
  fi
fi
# END: 5d8f5a6b3c4e

done
