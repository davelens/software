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
rvm install 2.0.0
rvm use ruby-2.0.0 --default

# Install Ruby On Rails + bundler
gem install rails bundler

# Install capistrano
gem install capistrano

# Install imagemagick
# This fixes the issue described here: https://github.com/rmagick/rmagick/issues/36
brew install imagemagick --disable-openmp

# Install POW so we can use project.dev after symlinking
curl get.pow.cx | sh

echo "$(tput setaf 10)"
echo "Finished installing RVM, Ruby, and RoR!"
echo "If Guard is crashing on you in a Rails project, try a bundle update."
echo ""
echo "$(tput setaf 11)"
echo "IMPORTANT: Put the following line into your .bashrc or .bash_profile:"
echo ""
echo '[[ -s "$HOME/.rvm/scripts/rvm" ]] && . "$HOME/.rvm/scripts/rvm"'
echo "$(tput sgr0)"
