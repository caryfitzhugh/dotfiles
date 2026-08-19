git_prompt() {
    local branch
    branch=$(git branch --show-current 2>/dev/null)
    [[ -z "$branch" ]] && return

    if [[ -n "$(git status --porcelain 2>/dev/null)" ]]; then
        printf '\e[4m%s\e[24m*' "$branch"
    else
        printf '\e[4m%s\e[24m' "$branch"
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


export PS1='\[\e[38;2;45;212;191m\]\T $(git_prompt) $(smart_path) ❯ \[\e[0m\]'
