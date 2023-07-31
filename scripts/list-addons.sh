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

files=$(find $folder -name "*.name")
last_file=$(echo "$files" | tail -n 1)

printf "[\n"
for file in $files; do
  if [ -f "$file" ]; then
    name=$(basename "$file" .name)
    ext=$(echo "$file" | sed 's/.*\.//')
    if [ -n "$(find "$folder" -maxdepth 1 -type f -name "$name.*" -not -name "$name.$ext")" ]; then
      printf "  { \n    \"code\": \"$name\",\n    \"name\": \"$(cat "$file" | head -n 1)\"\n  }"
      if [ "$file" != "$last_file" ]; then
        printf ",\n"
      else
        printf "\n"
      fi
    fi
  fi
done
printf "]\n"
