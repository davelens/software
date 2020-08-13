#!/bin/bash

# Include a number of methods that are used throughout the installations
. helper.sh

# Guard clause and early exit when Homebrew is already installed
[ $(which brew) ] && exit 1

echo "$(tput setaf 7)Installing Homebrew..."

/usr/bin/ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
brew doctor
brew update
brew upgrade
brew bundle install

echo "$(tput setaf 7)Installing davelens/dotfiles"
git clone git@github.com:davelens/dotfiles.git ~/.dotfiles
cd ~/.dotfiles && ./install.sh
