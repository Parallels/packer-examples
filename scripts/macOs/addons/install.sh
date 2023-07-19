#!/bin/bash

echo "$ADDONS_DIR"
echo "$ADDONS"
echo "Listing tmp folder"
ls -la /tmp
echo "Listing addons folder"
ls -la "$ADDONS_DIR"
echo "Listing script folder"
ls -la "$ADDONS_DIR/scripts"

# Check if an argument was provided
if [ -z "$ADDONS" ]; then
  echo "Please provide a comma-separated list of values"
  exit 1
fi

# Convert the argument to an array
IFS=',' read -ra values <<<"$ADDONS"

# Loop through each value in the array
for value in "${values[@]}"; do
  if [ -n "$value" ]; then
    # Check if a script with the same name exists
    if [ -f "$ADDONS_DIR/scripts/$value.sh" ]; then
      # Execute the script
      bash "$ADDONS_DIR/scripts/$value.sh"
    else
      echo "Script $value.sh not found on the script folder, full path .$ADDONS_DIR/scripts/$value.sh"
    fi
  fi
done
