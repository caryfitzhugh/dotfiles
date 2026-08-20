#!/bin/bash
SCRIPT_DIR=$( cd -- "$( dirname -- "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )

mkdir -p ~/.vim/{swap,backup,undo}

rm -f ~/.vimrc
echo "source $SCRIPT_DIR/vim/VIMRC" > ~/.vimrc

PACKAGES=(
    vim
)
sudo apt update
sudo apt install -y "${PACKAGES[@]}"

vim -E -s -c 'PlugInstall --sync' -c 'qa!' 2>&1

exec bash $SCRIPT_DIR/setup_node.sh
