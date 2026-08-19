#!/usr/bin/env bash
set -e

# Install nvm if not already installed
if [[ ! -s "$HOME/.nvm/nvm.sh" ]]; then
    curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.40.6/install.sh | bash
fi
# Load nvm into this shell
export NVM_DIR="$HOME/.nvm"
source "$NVM_DIR/nvm.sh"

# Install and select the latest LTS Node
nvm install --lts
nvm alias default 'lts/*'
nvm use --lts

node --version
npm --version
