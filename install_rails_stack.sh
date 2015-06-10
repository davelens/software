#!/bin/bash

# Make sure we have homebrew etc. installed
. install_dependencies.sh

# Install RBENV and ruby-build
brew install rbenv ruby-build

# Check if RBENV installed correctly. We brutally exit if it did not install
if [[ ! -s "$HOME/.rbenv/version" ]]; then
	exit 1
fi

# Initialize RBENV once
eval "$(/usr/local/bin/rbenv init -)"

# Install Ruby 2.2.0 with RBENV, and make it the default ruby
rbenv install 2.2.0
rbenv global 2.2.0 --default

# Also install Ruby 1.9.3 for legacy projects
rbenv install 1.9.3-p448

# Install global bundler
gem install bundler

# Install imagemagick
# This fixes the issue described here: https://github.com/rmagick/rmagick/issues/36
brew install imagemagick --disable-openmp

# Install POW so we can use project.dev after symlinking
curl get.pow.cx | sh

echo "$(tput setaf 10)"
echo "Finished installing RBENV, Ruby, and RoR!"
echo ""
echo "$(tput setaf 11)"
echo "IMPORTANT: Put the following line into your .bashrc or .bash_profile:"
echo ""
echo 'eval "$(rbenv init -)"'
echo "$(tput sgr0)"
