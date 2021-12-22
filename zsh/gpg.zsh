if ! type "gpg-agent" > /dev/null; then return; fi
if [ -z $(pgrep gpg-agent) ]; then gpg-agent --daemon; fi
