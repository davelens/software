#!/bin/bash

# Install homebrew
/usr/bin/ruby -e "$(/usr/bin/curl -fsSL https://raw.github.com/mxcl/homebrew/master/Library/Contributions/install_homebrew.rb)"
brew doctor
brew update
brew upgrade

# Install misc. software
brew install autoconf
brew install mercurial
brew install git
brew install wget
brew install tmux

# Vim 7.3.5+ with python+ruby support
brew install https://raw.github.com/Homebrew/homebrew-dupes/master/vim.rb
