#!/bin/bash

# Make sure we have homebrew etc. installed
. install_dependencies.sh

# Install misc. software
brew install reattach-to-user-namespace
brew install tmux
brew install irssi
brew install ack
brew install vim

# Query the user if he/she wants to download/install additional apps
. install_apps.sh

echo "$(tput setaf 10)Done.$(tput sgr0)"
