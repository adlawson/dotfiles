[ ! -d "/opt/homebrew/opt/nvm" ] && return

export NVM_DIR="$HOME/.nvm"

load-nvmcompletion() {
  local rootdir="/opt/homebrew/opt"

  if [ "$(uname -p)" != "arm" ]; then
      rootdir="/usr/local/opt"
  fi

  [ -s "$rootdir/nvm/nvm.sh" ] && \. "$rootdir/nvm/nvm.sh" --no-use # This loads nvm
  [ -s "$rootdir/nvm/etc/bash_completion.d/nvm" ] && \. "$rootdir/nvm/etc/bash_completion.d/nvm" # This loads nvm bash_completion
}

load-nvmcompletion

[ ! -v NVM_AUTOLOAD_ENABLED ] && return
if ! type "nvm" > /dev/null; then return; fi

# https://github.com/nvm-sh/nvm#deeper-shell-integration
autoload -U add-zsh-hook
load-nvmrc() {
  local node_version="$(nvm version)"
  local nvmrc_path="$(nvm_find_nvmrc)"

  if [ -n "$nvmrc_path" ]; then
    local nvmrc_node_version=$(nvm version "$(cat "${nvmrc_path}")")
    if [ "$nvmrc_node_version" = "N/A" ]; then
      nvm install
    elif [ "$nvmrc_node_version" != "$node_version" ]; then
      nvm use
    fi
  elif [ "$node_version" != "$(nvm version default)" ]; then
    nvm use default
  fi
}

add-zsh-hook chpwd load-nvmrc
load-nvmrc
