#!/bin/bash

# The helper contains a number of methods to help us install our software
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

	# exit installer here
	echo "Please install the CLI tools for Mac OS X, then run this installer again."
	exit 1
fi

# @todo check if an id_rsa key is set; we'll need it for github auth
if [[ ! -f ~/.ssh/id_rsa ]]; then
	echo "$(tput setaf 9)"
	echo "ERROR: You do not have an SSH key set yet. You will need one that is linked to your GitHub account to proceed."
	exit 1
fi

echo "$(tput setaf 10)"
echo "Starting installation..."
echo "$(tput sgr0)"

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
brew tap homebrew/dupes
brew install https://raw.github.com/Homebrew/homebrew-dupes/master/vim.rb

# Download and install my dotfiles
git clone git@github.com:davelens/dotfiles ~/.dotfiles && cd ~/.dotfiles && chmod +x install.sh && ./install.sh && cd -

# MySQL - databases are run with your user account
brew install mysql
# Set up databases to run AS YOUR USER ACCOUNT with:
unset TMPDIR
mysql_install_db --verbose --user=$USER --basedir="$(brew --prefix mysql)" --datadir=/usr/local/var/mysql --tmpdir=/tmp
install mysql/.my.cnf.template ~/.my.cnf

# PHP
brew tap josegonzalez/homebrew-php
brew install php53 --with-mysql --with-intl --with-imap
install_template php/php.ini.template /usr/local/etc/php/5.3/php.ini
PHP_VERSION=`/usr/local/bin/php -v | awk '{print $2}' | head -1`

# PEAR with PHPUnit and CodeSniffer
sudo pear config-set auto_discover 1
sudo pear update-channels
sudo pear upgrade
sudo pear channel-discover pear.phpunit.de
sudo pear install PHP_Codesniffer

# oauth and apc
sudo pecl install oauth
sudo pecl install apc

# Use Mac OS X's apache, but install a custom conf
install_template_as_root apache/httpd.conf.template /etc/apache2/httpd.conf
sed -i '' "s/{{PHP_VERSION}}/$PHP_VERSION/" $CURRENTDIR/apache/httpd.conf

# Query the user if he/she wants to download/install additional apps
. install_apps.sh

echo "$(tput setaf 11)"
echo "###################################################################"
echo "# Set MySQL password by using:"
echo "#  mysqladmin -u root password 'new-password'"
echo "#  mysqladmin -u root -h $(hostname -f) password 'new-password'"
echo "###################################################################"
echo "$(tput sgr0)"
echo "$(tput setaf 10)Done.$(tput sgr0)"
