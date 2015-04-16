#!/bin/bash

# The helper contains a number of methods to help us install our software
. helper.sh
. install_dependencies.sh

echo ""
echo -n "$(tput setaf 11)Would you like to download additional software?$(tput sgr0) $(tput bold)(y/n)$(tput setaf 11):$(tput sgr0) "
read downloadDMGFiles

if [ $(lowercase $downloadDMGFiles) == "y" ]; then
  echo 'Now would be a good time to grab a coffee, this will probably take a while.'
  brew cask install alfred
  brew cask install firefox
  brew cask install iterm2
  brew cask install onepassword
  brew cask install libreoffice
  brew cask install spotify
  brew cask install unrarx
  brew cask install vlc
fi
