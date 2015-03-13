source ~/.bash/lib/git-prompt.bash

function __name_and_server {
    if [ -n "$SSH_CLIENT" ] || [ -n "$SSH_TTY" ]; then
        echo "\u@\h"
    else
        echo "\u"
    fi
}

function bash_prompt {
    if [[ 'function' = $(type -t __git_ps1) ]]; then
        PROMPT_COMMAND='__git_ps1 "$(__name_and_server) \W" "\$ " " [%s]"'
    else
        PS1="$(__name_and_server) \w\$ "
    fi
}

bash_prompt
unset bash_prompt
