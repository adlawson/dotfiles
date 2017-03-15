#!/usr/bin/env bash

ruby -e "$(curl -fsSL https://githubusercontent.com/Homebrew/install/master/install)"

brew tap caskroom/cask

brew install wget
brew install git
brew install vim
brew install pass
brew install gnupg2
brew install bash-completion
brew install pinentry-mac

brew cask install google-chrome
brew cask install iterm2
brew cask install slack
brew cask install atom
brew cask install docker
brew cask install gpgtools
brew cask install keybase
brew cask install spotify
brew cask install clamxav

ln -s ~/Projects/adlawson/pass ~/.password-store
