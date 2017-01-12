#!/bin/bash

# Make sure we have homebrew etc. installed
. install_dependencies.sh

# MySQL - databases are run with your user account
brew install mysql
# Set up databases to run AS YOUR USER ACCOUNT with:
unset TMPDIR
mysql_install_db --verbose --user=$USER --basedir="$(brew --prefix mysql)" --datadir=/usr/local/var/mysql --tmpdir=/tmp
install mysql/.my.cnf.template ~/.my.cnf
mysql_secure_installation

# PHP 5.5 with intl support + memcache
# The *.so files for these extensions will load from a separate .ini file located in /usr/local/etc/php/5.5/conf.d/
brew tap josegonzalez/homebrew-php
brew install php55 --with-apache --with-mysql --with-imap
brew install php55-intl
brew install php55-memcache
install_template php/php.ini.template /usr/local/etc/php/5.5/php.ini

# PEAR with PHPUnit and CodeSniffer
#sudo pear config-set auto_discover 1
#sudo pear update-channels
#sudo pear upgrade
#sudo pear channel-discover pear.phpunit.de
#sudo pear install PHP_Codesniffer

# oauth and apc
#sudo pecl install oauth
#sudo pecl install apc

# Use Mac OS X's apache, but install a custom conf
PHP_DIR=`brew info php55 | awk '{print $1}' | grep /usr/local/Cellar`
install_template_as_root apache/httpd.conf.template /etc/apache2/httpd.conf
sed -i '' "s,{{PHP_DIR}},$PHP_DIR," $CURRENTDIR/apache/httpd.conf

# Install POW so we can use project.company.dev without editing /etc/hosts
curl get.pow.cx | sh

echo "$(tput setaf 11)"
echo "Finished installing PHP and MySQL"
echo "$(tput sgr0)"
