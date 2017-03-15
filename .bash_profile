# This file is managed by adlawson/dotfiles

# From dotfiles source
. ~/.dotfiles/bash/path.sh
. ~/.dotfiles/bash/env.sh
. ~/.dotfiles/bash/prompt.sh
. ~/.dotfiles/bash/alias.sh

# From local environment
[ -f $(brew --prefix)/etc/bash_completion ] && . $(brew --prefix)/etc/bash_completion
[ -f ~/.gpg-agent-info ] && . ~/.gpg-agent-info
