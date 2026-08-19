BASHRC_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

for file in "$BASHRC_DIR"/bashrc.d/*.bash; do
    [[ -r "$file" ]] && source "$file"
done
