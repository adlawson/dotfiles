typeset -aHg ADL_PROMPT_SEGMENTS=(
    prompt_aws
    prompt_gcp
    prompt_k8s
    prompt_dir
    prompt_git
    prompt_end
)

# PROMPT
ADL_PROMPT_BG=NONE
ADL_PROMPT_SEPARATOR="\ue0b0"

# DIR
ADL_PROMPT_DIR_BG=32m
ADL_PROMPT_DIR_FG=white

# GIT
ADL_PROMPT_GIT_BG=162m
ADL_PROMPT_GIT_FG=white
ADL_PROMPT_GIT_PREFIX="\uf418"

# K8S
ADL_PROMPT_K8S_BG=56m
ADL_PROMPT_K8S_FG=white
ADL_PROMPT_K8S_KCONFIG="${HOME}/.kube/config"
ADL_PROMPT_K8S_PREFIX="󰢌"

# GCP
ADL_PROMPT_GCP_BG=yellow
ADL_PROMPT_GCP_FG=white

# AWS
ADL_PROMPT_AWS_BG=yellow
ADL_PROMPT_AWS_FG=white

_adlawson_prompt_segment() {
  local bg fg
  [[ -n $1 ]] && bg="%K{$1}" || bg="%k"
  [[ -n $2 ]] && fg="%F{$2}" || fg="%f"
  if [[ $ADL_PROMPT_BG != 'NONE' && $1 != $ADL_PROMPT_BG ]]; then
    print -n "%{$bg%F{$ADL_PROMPT_BG}%}$ADL_PROMPT_SEPARATOR%{$fg%}"
  else
    print -n "%{$bg%}%{$fg%}"
  fi
  ADL_PROMPT_BG=$1
  [[ -n $3 ]] && print -n $3
}

prompt_end() {
  if [[ -n $ADL_PROMPT_BG ]]; then
    print -n "%{%k%F{$ADL_PROMPT_BG}%}$ADL_PROMPT_SEPARATOR"
  else
    print -n "%{%k%}"
  fi
  print -n "%{%f%}"
  ADL_PROMPT_BG=''
}

prompt_git() {
  local color ref
  $(command git symbolic-ref HEAD &>/dev/null)
  if [[ "$?" -eq 0 ]]; then
    export ZSH_THEME_GIT_PROMPT_PREFIX=''
    export ZSH_THEME_GIT_PROMPT_SUFFIX=''
    _adlawson_prompt_segment $ADL_PROMPT_GIT_BG $ADL_PROMPT_GIT_FG " $ADL_PROMPT_GIT_PREFIX $(git_prompt_info) "
  fi
}

prompt_dir() {
  _adlawson_prompt_segment $ADL_PROMPT_DIR_BG $ADL_PROMPT_DIR_FG ' %1~ '
}

prompt_k8s() {
  if [[ -f $ADL_PROMPT_K8S_KCONFIG ]]; then
      local context
      context=$(cat $ADL_PROMPT_K8S_KCONFIG | grep current-context | awk '{print $2}')
      if [[ "$context" != "docker-desktop" && "$context" != "" ]]; then
        _adlawson_prompt_segment $ADL_PROMPT_K8S_BG $ADL_PROMPT_K8S_FG " $ADL_PROMPT_K8S_PREFIX $context "
      fi
  fi
}

prompt_gcp() {
}

prompt_aws() {
}

prompt_main() {
  RETVAL=$?
  CURRENT_BG='NONE'
  for _adlawson_prompt_segment in "${ADL_PROMPT_SEGMENTS[@]}"; do
    [[ -n $_adlawson_prompt_segment ]] && $_adlawson_prompt_segment
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
