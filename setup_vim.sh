#!/bin/bash
SCRIPT_DIR=$( cd -- "$( dirname -- "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )

mkdir -p ~/.vim/{swap,backup,undo}

rm ~/.vimrc
ln -s $SCRIPT_DIR/vim/VIMRC ~/.vimrc

PACKAGES=(
    vim
)
sudo apt update
sudo apt install -y "${PACKAGES[@]}"
