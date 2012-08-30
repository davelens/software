#!/bin/bash

# The helper contains a number of methods to help us install our software
. helper.sh

echo ""
echo -n "$(tput setaf 11)Would you like to download additional software?$(tput sgr0) $(tput bold)(y/n)$(tput setaf 11):$(tput sgr0) "
read downloadDMGFiles

if [ $(lowercase $downloadDMGFiles) == "y" ]; then
	# We need an Applications folder in our home dir
	mkdir ~/Applications 2> /dev/null

	# Download and install iTerm2
	if [ ! -d ~/Applications/iTerm.app ]; then
		wget -O ~/Downloads/iterm2.zip http://iterm2.googlecode.com/files/iTerm2-1_0_0_20120726.zip && unzip ~/Downloads/iterm2.zip && mv iTerm.app ~/Applications/iTerm.app && rm *iTerm2*
	else
		echo "$(tput setaf 10)iTerm2 is already installed.$(tput sgr0)"
	fi

	# Download a bunch of .dmg files

	# Alfred
	if [ ! -d ~/Applications/Alfred.app ]; then
		download_dmg "$(curl -s http://www.alfredapp.com | grep '.dmg')" ~/Downloads/alfred.dmg
	else
		echo "$(tput setaf 10)Alfred is already installed.$(tput sgr0)"
	fi

	# Latest Firefox
	if [ ! -d ~/Applications/Firefox.app ]; then
		download_dmg "$(curl -s http://www.mozilla.org/en-US/firefox/fx/?from=getfirefox#desktop | grep 'Mac OS X')" ~/Downloads/firefox.dmg
	else
		echo "$(tput setaf 10)Firefox is already installed.$(tput sgr0)"
	fi

	# MySQL Workbench
	if [ ! -d ~/Applications/MySQLWorkbench.app ]; then
		wget -O ~/Downloads/mysql-workbench.dmg http://cdn.mysql.com/Downloads/MySQLGUITools/mysql-workbench-gpl-5.2.41-osx-i686.dmg
	else
		echo "$(tput setaf 10)MySQLWorkbench is already installed.$(tput sgr0)"
	fi
else
	echo ""
fi

