#!/bin/bash

# Make sure we have homebrew etc. installed
. install_dependencies.sh

# Install misc. software
brew install reattach-to-user-namespace tmux irssi ack vim

# rbenv, ruby-build, bundler, imagemagick@6
. install_ruby.sh

# Query the user if he/she wants to download/install additional apps
. install_apps.sh

echo $(tput setaf 2)'Done!'
