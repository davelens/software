#!/bin/bash

# Make sure we have homebrew etc. installed
. install_dependencies.sh

# Install rbenv and ruby-build
brew install rbenv ruby-build

# Check if rbenv installed correctly. We brutally exit if it did not install
if [[ ! -s "$HOME/.rbenv/version" ]]; then
	exit 1
fi

# Initialize rbenv once
eval "$(/usr/local/bin/rbenv init -)"

# Install our main Ruby with rbenv, and make it the default ruby
rbenv install 2.3.1
rbenv global 2.3.1 --default

# Also install Ruby 1.9.3 for legacy projects
rbenv install 1.9.3-p551

# Install global bundler
gem install bundler

# Install imagemagick
# This fixes the issue described here: https://github.com/rmagick/rmagick/issues/36
brew install imagemagick@6 --disable-openmp

# Our local webserver
gem install puma
brew install puma/puma/puma-dev
sudo puma-dev -setup
## This line configures Puma to use .test and the ~/.pow dir for project
## symlinks. This is intended to have a more seamless transition from POW.
puma-dev -install -d test -dir ~/.pow/

echo "$(tput setaf 10)"
echo "Finished installing rbenv, Ruby, and Rails!"
echo ""
echo "$(tput setaf 11)"
echo "IMPORTANT: Put the following line into your .bashrc or .bash_profile:"
echo ""
echo 'eval "$(rbenv init -)"'
echo "$(tput sgr0)"
