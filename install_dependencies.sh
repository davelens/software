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

  /usr/bin/ruby -e "$(/usr/bin/curl -fsSL https://raw.github.com/mxcl/homebrew/go/install)"
  brew doctor
  brew update
  brew upgrade

  # Install CLI tools
  if [[ $(which gcc) != "" ]]; then
    brew tap homebrew/versions
    brew install gcc48
  fi

  # Install brew-cask
  brew tap caskroom/cask
  brew install brew-cask

  # Install the git and compilation dependencies & tools
  brew tap homebrew/dupes
  brew install autoconf automake
  brew install libtool libyaml libxml2 libxslt libksba openssl sqlite
  brew install mercurial
  brew install git
  brew install cmake
  brew install wget
  brew install hub
fi
