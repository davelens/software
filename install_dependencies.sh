#!/bin/bash

# Include a number of methods that are used throughout the installations
. helper.sh

# Check if an id_rsa key is set; we'll need it for github auth
if [[ ! -f ~/.ssh/id_rsa ]]; then
  echo "$(tput setaf 9)"
  echo "ERROR: You do not have an SSH key set yet. You need one linked to your GitHub account."
  echo "Ignore this error if have one that is not named id_rsa."
  exit 1
fi

# Install homebrew
if [[ $(which brew) == "" ]]; then
  echo "$(tput setaf 11)"
  echo "Installing Homebrew..."
  echo "$(tput sgr0)"

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
fi
