#!/bin/bash -eux

SELECTED_ADDONS="${ADDONS:-}"

BASE_DIR=$(cd "$(dirname "$0")" && pwd)

if [ -z "$SELECTED_ADDONS" ]; then
  echo "No addons provided. Skipping."
  exit 0
fi

echo "Installing addons: $SELECTED_ADDONS from $BASE_DIR"

IFS=',' read -ra values <<< "$SELECTED_ADDONS"

for value in "${values[@]}"; do
  value=$(echo "$value" | xargs)
  
  if [ -n "$value" ]; then
    SCRIPT_PATH="$BASE_DIR/scripts/$value.sh"
    
    if [ -f "$SCRIPT_PATH" ]; then
      echo "==> Executing addon script: $value"
      bash "$SCRIPT_PATH"
    else
      echo "ERROR: Script not found at $SCRIPT_PATH"
      exit 1
    fi
  fi
done