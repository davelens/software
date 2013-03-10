#!/bin/bash

# Make sure we have homebrew etc. installed
. install_dependencies.sh

# MySQL - databases are run with your user account
brew install mysql
# Set up databases to run AS YOUR USER ACCOUNT with:
unset TMPDIR
mysql_install_db --verbose --user=$USER --basedir="$(brew --prefix mysql)" --datadir=/usr/local/var/mysql --tmpdir=/tmp
install mysql/.my.cnf.template ~/.my.cnf

# PHP
brew tap josegonzalez/homebrew-php
brew install php53-intl --with-mysql --with-imap
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

echo "$(tput setaf 11)"
echo "###################################################################"
echo "# Set MySQL password by using:"
echo "#  mysqladmin -u root password 'new-password'"
echo "#  mysqladmin -u root -h $(hostname -f) password 'new-password'"
echo "###################################################################"
echo "$(tput sgr0)"
