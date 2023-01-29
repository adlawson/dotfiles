typeset -aHg PROMPT_SEGMENTS=(
    prompt_dir
    prompt_git
    prompt_end
)

CURRENT_BG=NONE
PRIMARY_FG=white
SEGMENT_SEPARATOR="\ue0b0"
BRANCH="\uf418"

prompt_segment() {
  local bg fg
  [[ -n $1 ]] && bg="%K{$1}" || bg="%k"
  [[ -n $2 ]] && fg="%F{$2}" || fg="%f"
  if [[ $CURRENT_BG != 'NONE' && $1 != $CURRENT_BG ]]; then
    print -n "%{$bg%F{$CURRENT_BG}%}$SEGMENT_SEPARATOR%{$fg%}"
  else
    print -n "%{$bg%}%{$fg%}"
  fi
  CURRENT_BG=$1
  [[ -n $3 ]] && print -n $3
}

prompt_end() {
  if [[ -n $CURRENT_BG ]]; then
    print -n "%{%k%F{$CURRENT_BG}%}$SEGMENT_SEPARATOR"
  else
    print -n "%{%k%}"
  fi
  print -n "%{%f%}"
  CURRENT_BG=''
}

prompt_git() {
  local color ref
  $(command git symbolic-ref HEAD &>/dev/null)
  if [[ "$?" -eq 0 ]]; then
    color=162m
    ref=$(git_current_branch)
    prompt_segment $color $PRIMARY_FG
    print -n " $BRANCH $ref "
  fi
}

prompt_dir() {
  prompt_segment 32m $PRIMARY_FG ' %1~ '
}

prompt_main() {
  RETVAL=$?
  CURRENT_BG='NONE'
  for prompt_segment in "${PROMPT_SEGMENTS[@]}"; do
    [[ -n $prompt_segment ]] && $prompt_segment
  done
}

prompt_precmd() {
  vcs_info
  PROMPT='%{%f%b%k%}$(prompt_main) '
}

prompt_setup() {
  autoload -Uz add-zsh-hook
  autoload -Uz vcs_info

  prompt_opts=(cr subst percent)

  add-zsh-hook precmd prompt_precmd

  zstyle ':vcs_info:*' enable git
  zstyle ':vcs_info:*' check-for-changes false
  zstyle ':vcs_info:git*' formats '%b'
  zstyle ':vcs_info:git*' actionformats '%b (%a)'
}

prompt_setup "$@"
