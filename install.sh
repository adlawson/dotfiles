#!/usr/bin/env bash
read -p "This may overwrite existing files in your home directory. Are you sure? (y/n) "
echo
if [[ $REPLY =~ ^[Yy]$ ]]; then
    rsync --exclude ".git/" --exclude ".DS_Store" --exclude "install.sh" \
          --exclude "README.md" --exclude ".gitmodules" -av --no-perms . ~
    source ~/.bash_profile
fi
