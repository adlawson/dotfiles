#!/bin/zsh

alias dotfiles=_adlawson_dotfiles

local _adlawson_dotfiles() {
  case $1 in
    install) shift; dotfiles brew && \
                    dotfiles git config --local status.showUntrackedFiles no && \
                    dotfiles git submodule update --init && \
                    vim +PlugInstall +qall ;;
       brew) shift; brew bundle --file="$HOME/.config/Brewfile" $@ ;;
        git) shift; git --git-dir="$HOME/.dotfiles/" --work-tree="$HOME" $@ ;;
          *) git --git-dir="$HOME/.dotfiles/" --work-tree="$HOME" $@ ;;
  esac
}
