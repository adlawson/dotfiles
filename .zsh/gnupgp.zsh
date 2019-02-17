export SSH_AUTH_SOCK=$HOME/.gnupg/S.gpg-agent.ssh
if [ -z $(pgrep gpg-agent) ]; then gpg-agent --daemon; fi
[ -f $HOME/src/github.com/monzo/starter-pack/zshrc ] && source $HOME/src/github.com/monzo/starter-pack/zshrc

gpg-connect-agent updatestartuptty /bye >/dev/null 2>&1
