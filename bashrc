for file in "$DOTFILES_BASH_DIR/bashrc.d/"*.bash; do
    [[ -r "$file" ]] && source "$file"
done
