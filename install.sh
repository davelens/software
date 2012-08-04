#!/bin/bash

# The helper contains a number of methods to help us install our software
. helper.sh

# Let's give our password first so we don't get bugged halfway through the install
su $USER

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

# Vim 7.3.5+ with python+ruby support
brew install https://raw.github.com/Homebrew/homebrew-dupes/master/vim.rb

# Download and install my dotfiles
git clone git@github.com:davelens/dotfiles ~/.dotfiles && chmod +x ~/.dotfiles/install.sh && /.~/.dotfiles/install.sh

# MySQL - databases are run with your user account
brew install mysql
# Set up databases to run AS YOUR USER ACCOUNT with:
unset TMPDIR
mysql_install_db --verbose --user=$USER --basedir="$(brew --prefix mysql)" --datadir=/usr/local/var/mysql --tmpdir=/tmp
# @todo install mysql pref. pane
install mysql/.my.cnf ~/.my.cnf

# install PHP
brew tap josegonzalez/homebrew-php
brew install php53 --with-mysql --with-intl --with-imap
install_template php/php.ini.template /usr/local/etc/php/5.3/php.ini
PHP_VERSION=`php -v | awk '{print $2}' | head -1`

# fix pear
sudo pear config-set auto_discover 1
sudo pear update-channels
sudo pear upgrade

# install pear packages
sudo pear channel-discover pear.phpunit.de
sudo pear install PHP_Codesniffer

# install
pecl install oauth
pecl install apc

# Use Mac OS X's apache, but install a custom conf
install_template_as_root apache/httpd.conf.template /etc/apache2/httpd.conf

echo "Make MySQL load on startup: "
echo ""
echo "Set MySQL password by using: "
echo "  mysqladmin -u root password 'new-password'"
echo "  mysqladmin -u root -h $(hostname -f) password 'new-password'"
echo "add LoadModule php5_module    /usr/local/Cellar/php53/$PHP_VERSION/libexec/apache2/libphp5.so into /etc/apache2/httpd.conf"
