RESET=$'\001\e[0m\002'
DIM=$'\001\e[2m\002'
NO_DIM=$'\001\e[22m\002'

BOLD=$'\001\e[1m\002'
NO_BOLD=$'\001\e[22m\002'

UNDERLINE=$'\001\e[4m\002'
NO_UNDERLINE=$'\001\e[24m\002'

REVERSE=$'\001\e[7m\002'
NO_REVERSE=$'\001\e[27m\002'

ITALIC=$'\001\e[3m\002'
NO_ITALIC=$'\001\e[23m\002'

STRIKETHROUGH=$'\001\e[9m\002'
NO_STRIKETHROUGH=$'\001\e[29m\002'

BLACK=$'\001\e[30m\002'
RED=$'\001\e[31m\002'
GREEN=$'\001\e[32m\002'
YELLOW=$'\001\e[33m\002'
BLUE=$'\001\e[34m\002'
MAGENTA=$'\001\e[35m\002'
CYAN=$'\001\e[36m\002'
WHITE=$'\001\e[37m\002'

BRIGHT_BLACK=$'\001\e[90m\002'
BRIGHT_RED=$'\001\e[91m\002'
BRIGHT_GREEN=$'\001\e[92m\002'
BRIGHT_YELLOW=$'\001\e[93m\002'
BRIGHT_BLUE=$'\001\e[94m\002'
BRIGHT_MAGENTA=$'\001\e[95m\002'
BRIGHT_CYAN=$'\001\e[96m\002'
BRIGHT_WHITE=$'\001\e[97m\002'

git_prompt() {
    local branch
    branch=$(git branch --show-current 2>/dev/null)
    [[ -z "$branch" ]] && return

    if [[ -n "$(git status --porcelain 2>/dev/null)" ]]; then
        printf '%s%s%s' "$BOLD" "$branch" "$NO_BOLD"
    else
        printf '%s%s%s' "$DIM" "$branch" "$NO_DIM"
    fi
}

smart_path() {
    local path="$PWD"
    local max_len=20

    # Replace $HOME with ~
    [[ "$path" == "$HOME"* ]] && path="~${path#$HOME}"

    # Don't shorten short paths
    if (( ${#path} <= max_len )); then
        printf '%s' "$path"
        return
    fi

    local IFS='/'
    local parts
    read -ra parts <<< "$path"

    local result=""
    local last=$((${#parts[@]} - 1))

    # Preserve ~ or /, then abbreviate intermediate directories
    for ((i=0; i<last; i++)); do
        [[ -z "${parts[i]}" ]] && continue

        if [[ "${parts[i]}" == "~" ]]; then
            result+="~/"
        else
            result+="${parts[i]:0:1}/"
        fi
    done
    result+="${parts[last]}"

    printf '%s' "$result"
}

export PS1='${DIM}\T${NO_DIM} $(git_prompt) $(smart_path)❯ '
