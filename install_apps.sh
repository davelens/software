#!/bin/bash

# The helper contains a number of methods to help us install our software
. helper.sh
. install_dependencies.sh

echo ""
echo -n "$(tput setaf 11)Would you like to download additional software?$(tput sgr0) $(tput bold)(y/n)$(tput setaf 11):$(tput sgr0) "
read install_apps
