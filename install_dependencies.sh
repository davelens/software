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

# Install brew-cask
brew tap caskroom/cask

# Install the git and compilation dependencies & tools
brew install autoconf automake cmake
brew install libtool libyaml libxml2 libxslt libksba openssl sqlite
brew install mercurial git hub
brew install ack wget fzf the_silver_searcher fd
brew install youtube-dl irssi
brew install bash-completion

# alt is a CLI tool to help find an alternate path for a given path.
brew tap "uptech/homebrew-oss"
brew install uptech/oss/alt

echo "$(tput setaf 2)Homebrew installation complete!"
