#!/usr/bin/env bash

symlink() {
    local source="$1" destination="$2"
    [ ! -e $destination ] && ln -s $PWD/$source $destination
    [ ! -L $destination ] && echo "File at path $destination already exists" 1>&2
}

home() {
    local path="$1"
    symlink "$path" "$HOME/$path"
}

# Update dotfiles submodules
git submodule update --init

# Create necessary directories
mkdir -p $HOME/.atom
mkdir -p $HOME/.gnupg

# Link config to home directory
home ".atom/config.cson"
home ".bash_profile"
home ".dotfiles"
home ".gnupg/gpg-agent.conf"
home ".gnupg/gpg.conf"
home ".gitconfig"
home ".my.cnf"
home ".vim"
home ".vimrc"

# Install vim plugins
vim +BundleInstall +qall

# Resource
. ~/.bash_profile
