#!/bin/bash

# The helper contains a number of methods to help us install our software
. helper.sh

# wget > everything else
brew install wget

echo ""
echo -n "$(tput setaf 11)Would you like to download additional software?$(tput sgr0) $(tput bold)(y/n)$(tput setaf 11):$(tput sgr0) "
read downloadDMGFiles

if [ $(lowercase $downloadDMGFiles) == "y" ]; then
	# We need an Applications folder in our home dir
	mkdir ~/Applications 2> /dev/null

	# Download and install iTerm2
	if [ ! -d ~/Applications/iTerm.app ]; then
		wget -O ~/Downloads/iterm2.zip http://iterm2.googlecode.com/files/iTerm2-1_0_0_20130210.zip && unzip ~/Downloads/iterm2.zip && mv iTerm.app ~/Applications/iTerm.app
		rm *iTerm2* ~/Downloads/iterm2.zip
	else
		echo "$(tput setaf 10)iTerm2 is already installed.$(tput sgr0)"
	fi

	# Download a bunch of .dmg files

	# Alfred
	if [ ! -d ~/Applications/Alfred.app ]; then
		download_dmg "$(curl -s http://www.alfredapp.com | grep '.zip')" ~/Downloads/alfred.zip && unzip ~/Downloads/alfred.zip && mv Alfred.app ~/Applications/Alfred.app
		rm *Alfred* ~/Downloads/alfred.zip
	else
		echo "$(tput setaf 10)Alfred is already installed.$(tput sgr0)"
	fi
else
	echo ""
fi
