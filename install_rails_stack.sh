#!/bin/bash

# Make sure we have homebrew etc. installed
. install_dependencies.sh

# Install RVM
bash -s master < <(curl -L https://get.rvm.io)

# Check if RVM installed correctly. We brutally exit if it did not install
if [[ ! -s "$HOME/.rvm/scripts/rvm" ]]; then
	exit 1
fi

# Load RVM once
. "$HOME/.rvm/scripts/rvm"

# Install Ruby 1.9.3 with RVM, and make it the default ruby
rvm install 1.9.3
rvm use ruby-1.9.3 --default

# Install Ruby On Rails + bundler
gem install rails bundler

# Install capistrano
gem install capistrano

echo "$(tput setaf 10)"
echo "Finished installing RVM, Ruby, and RoR!"
echo ""
echo "$(tput setaf 11)"
echo "IMPORTANT: Put the following line into your .bashrc or .bash_profile:"
echo ""
echo '[[ -s "$HOME/.rvm/scripts/rvm" ]] && . "$HOME/.rvm/scripts/rvm"'
echo "$(tput sgr0)"