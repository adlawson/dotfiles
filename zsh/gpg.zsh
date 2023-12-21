if ! type "gpg-agent" > /dev/null; then return; fi
if [ -z $(pgrep gpg-agent | head -n1) ]; then eval $(gpg-agent --daemon); fi

