#!/bin/bash

# Dependencies are primarily homebrew and some libraries.
. install_dependencies.sh

# We exit if rbenv did not install correctly.
brew install rbenv ruby-build
[[ ! -s "$HOME/.rbenv/version" ]] && exit 1

# Initialize rbenv once
eval "$(/usr/local/bin/rbenv init -)"

# Install our main Ruby with rbenv, and make it the default ruby
rbenv install 2.4.4
rbenv global 2.4.4 --default

# Install global bundler
gem install bundler
bundle # Process the Gemfile included in this repo.

# NOTE: Remember that if you have issues with the mysql2 gem, it's probably
# because it cannot find the openssl lib. You need to explicitly pass LD/CPP
# flags to get it to compile.
#bundle config --local build.mysql2 "--with-ldflags=-L/usr/local/opt/openssl/lib --with-cppflags=-I/usr/local/opt/openssl/include"

# --disable-openmp fixes the issue described here: https://github.com/rmagick/rmagick/issues/36
brew install imagemagick@6 --disable-openmp

echo 'IMPORTANT: Put the following line into your .bashrc or .bash_profile:'
echo ''
echo 'eval "$(rbenv init -)"'
echo ''
echo $(tput setaf 2)'Done!'
