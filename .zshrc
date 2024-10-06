autoload -Uz compinit; compinit

eval "$(oh-my-posh init zsh --config ~/.config/ohmyposh/settings.json)"

for f (~/.config/zsh/**/*.zsh(N.)) . $f
