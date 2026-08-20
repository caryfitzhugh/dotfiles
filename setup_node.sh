#!/usr/bin/env bash
set -e

SOURCE_NEW_NVM=false
# Install nvm if not already installed
if [[ ! -s "$HOME/.nvm/nvm.sh" ]]; then
    curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.40.6/install.sh | bash
	SOURCE_NEW_NVM=true
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

if [[ "$SOURCE_NEW_NVM" == true ]]; then
	export NVM_DIR="$HOME/.nvm"
	[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
	[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion
fi
