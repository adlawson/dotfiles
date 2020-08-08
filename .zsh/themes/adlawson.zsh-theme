ZSH_THEME_GIT_PROMPT_PREFIX=" "
ZSH_THEME_GIT_PROMPT_SUFFIX=" "

# Outputs current branch info in prompt format
function git_prompt_info_fast() {
  $(command git symbolic-ref HEAD &>/dev/null)
  if [[ "$?" -eq 0 ]]; then
    echo "%{$fg[blue]%}$ZSH_THEME_GIT_PROMPT_PREFIX%{$reset_color%}$(git_current_branch)$ZSH_THEME_GIT_PROMPT_SUFFIX%{$reset_color%}"
  fi
}

PROMPT='$(git_prompt_info_fast)%{$fg[blue]%}▸%{$reset_color%} '

