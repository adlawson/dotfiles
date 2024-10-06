# Dotfiles

Personal dotfiles. No configuration options.

```shell
git clone --bare https://github.com/adlawson/dotfiles.git ~/.dotfiles
git --git-dir=~/dotfiles/ --work-tree="$HOME" checkout
source ~/.config/zsh/dotfiles.zsh
dotfiles install
```
