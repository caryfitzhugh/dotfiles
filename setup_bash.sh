#!/bin/bash
SCRIPT_DIR=$( cd -- "$( dirname -- "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )

add_bashrc_line() {
    local line="$1"

    grep -qxF "$line" "$HOME/.bashrc" || echo "$line" >> "$HOME/.bashrc"
}

add_bashrc_line "[ -f \"$SCRIPT_DIR/bashrc\" ] && source \"$SCRIPT_DIR/bashrc\""
echo "checking''."
