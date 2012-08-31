#!/bin/bash

# Make sure we have homebrew etc. installed
. install_dependencies.sh

# Install misc. software
brew install wget
brew install tmux
brew install irssi
brew install ack

# Vim 7.3.5+ with python+ruby support
brew tap homebrew/dupes
brew install https://raw.github.com/Homebrew/homebrew-dupes/master/vim.rb

# Use brew to install mysql, php+apc, pear, and configure Apache/PHP
. install_mamp_stack.sh

# Query the user if he/she wants to download/install additional apps
. install_apps.sh

echo "$(tput setaf 10)Done.$(tput sgr0)"
