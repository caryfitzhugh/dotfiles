#!/bin/bash
SCRIPT_DIR=$( cd -- "$( dirname -- "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )

mkdir -p ~/.vim/{swap,backup,undo}

rm ~/.vimrc
ln -s ~/.vimrc $SCRIPT_DIR/vim/VIMRC
