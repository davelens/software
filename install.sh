#!/bin/bash

# The helper contains a number of methods to help us install our software
. helper.sh

# Install homebrew
/usr/bin/ruby -e "$(/usr/bin/curl -fsSL https://raw.github.com/mxcl/homebrew/master/Library/Contributions/install_homebrew.rb)"
brew doctor
brew update
brew upgrade

# Install misc. software
brew install autoconf
brew install mercurial
brew install git
brew install wget
brew install tmux
brew install irssi
brew install ack

# Vim 7.3.5+ with python+ruby support
brew install https://raw.github.com/Homebrew/homebrew-dupes/master/vim.rb

# Download and install my dotfiles
git clone git@github.com:davelens/dotfiles ~/.dotfiles && cd ~/.dotfiles && chmod +x install.sh && ./install.sh && cd -

# MySQL - databases are run with your user account
brew install mysql
# Set up databases to run AS YOUR USER ACCOUNT with:
unset TMPDIR
mysql_install_db --verbose --user=$USER --basedir="$(brew --prefix mysql)" --datadir=/usr/local/var/mysql --tmpdir=/tmp
install mysql/.my.cnf.template ~/.my.cnf

# install PHP
brew tap josegonzalez/homebrew-php
brew install php53 --with-mysql --with-intl --with-imap
install_template php/php.ini.template /usr/local/etc/php/5.3/php.ini
PHP_VERSION=`/usr/local/bin/php -v | awk '{print $2}' | head -1`

# fix pear
sudo pear config-set auto_discover 1
sudo pear update-channels
sudo pear upgrade

# install pear packages
sudo pear channel-discover pear.phpunit.de
sudo pear install PHP_Codesniffer

# install
sudo pecl install oauth
sudo pecl install apc

# Use Mac OS X's apache, but install a custom conf
install_template_as_root apache/httpd.conf.template /etc/apache2/httpd.conf
sed -i '' "s/{{PHP_VERSION}}/$PHP_VERSION/" $CURRENTDIR/apache/httpd.conf

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
		echo "$(tput setaf 9)iTerm2 is already installed.$(tput sgr0)"
	fi

	# Download a bunch of .dmg files

	# Alfred
	if [ ! -d ~/Applications/Alfred.app ]; then
		download_dmg "$(curl -s http://www.alfredapp.com | grep '.dmg')" ~/Downloads/alfred.dmg
	else
		echo "$(tput setaf 9)Alfred is already installed.$(tput sgr0)"
	fi

	# Latest Firefox
	if [ ! -d ~/Applications/Firefox.app ]; then
		download_dmg "$(curl -s http://www.mozilla.org/en-US/firefox/fx/?from=getfirefox#desktop | grep 'Mac OS X')" ~/Downloads/firefox.dmg
	else
		echo "$(tput setaf 9)Firefox is already installed.$(tput sgr0)"
	fi

	# MySQL Workbench
	if [ ! -d ~/Applications/MySQLWorkbench.app ]; then
		wget -O ~/Downloads/mysql-workbench.dmg http://cdn.mysql.com/Downloads/MySQLGUITools/mysql-workbench-gpl-5.2.41-osx-i686.dmg
	else
		echo "$(tput setaf 9)MySQLWorkbench is already installed.$(tput sgr0)"
	fi
else
	echo ""
fi

echo "$(tput setaf 11)"
echo "###################################################################"
echo "# Set MySQL password by using:"
echo "#  mysqladmin -u root password 'new-password'"
echo "#  mysqladmin -u root -h $(hostname -f) password 'new-password'"
echo "###################################################################"
echo "$(tput sgr0)"
echo "$(tput setaf 10)Done.$(tput sgr0)"
