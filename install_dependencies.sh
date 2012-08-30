#!/bin/bash

# Include a number of methods that are used throughout the installations
. helper.sh

if [[ $(which gcc) == "" ]]; then
	echo "$(tput setaf 9)"
	echo "ERROR: You do not have Xcode or GCC installed. At least the commandline tools for Xcode are required to proceed."
	echo -n "$(tput setaf 11)Would you like to download the CLI tools for Mac OS X Lion?$(tput sgr0) $(tput bold)(y/n)$(tput setaf 11):$(tput sgr0) "
	read downloadGCC

	if [ $(lowercase $downloadGCC) == "y" ]; then
		echo "Opening Safari..."
		open -a Safari "https://developer.apple.com/downloads/download.action?path=Developer_Tools/command_line_tools_os_x_lion_for_xcode__august_2012/command_line_tools_for_xcode_os_x_lion_aug_2012.dmg"
	fi

	echo "Please install the CLI tools for Mac OS X, then run this installer again."
	exit 1
fi

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

	/usr/bin/ruby -e "$(/usr/bin/curl -fsSL https://raw.github.com/mxcl/homebrew/master/Library/Contributions/install_homebrew.rb)"
	brew doctor
	brew update
	brew upgrade

	# autoconf is need for various brew recipes, and mercurial is needed for git
	brew install autoconf
	brew install mercurial
	brew install git
fi

