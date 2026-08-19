git_prompt() {
  local branch
  branch=$(git branch --show-current 2>/dev/null)
  [[ -z "$branch" ]] && return

  if [[ -n "$(git status --porcelain 2>/dev/null)" ]]; then
    printf '\[\e[33m\](%s *)\[\e[0m\]' "$branch"
  else
    printf '\[\e[32m\](%s)\[\e[0m\]' "$branch"
  fi
}

PS1='\[\e[36m\]\w\[\e[0m\] $(git_prompt) \$ '
