#!/bin/sh -eux

/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Parallels/prlctl-scripts/main/ubuntu/install-vscode-server.sh)" - -i
code --install-extension ms-python.python
echo "{
    \"python.defaultInterpreterPath\": \"$HOME/.python_env/python_env/bin/python\"
}" > "$HOME/.config/Code/User/settings.json"
