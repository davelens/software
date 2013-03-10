#!/bin/bash

#########################################
# Methods by Tijs Verkoyen
#########################################

# grab the current dir
CURRENTDIR=$(pwd)
USER=$(whoami)

# check if the file is a symlink, if so it will be removed, if not a backup will be created
function remove_or_backup {
	if [ -h $1 ]
	then
		rm $1
	else
		if [ -f $1 ]
		then
			mv $1 $1.old
		fi
	fi
}

# install the symlink if the source file exists
function install {
	if [ -f $1 ]
	then
		remove_or_backup $2
		ln -s $CURRENTDIR/$1 $2
	fi
}

# install the symlink if the source file exists, and replace some vars inside the template
function install_template {
	if [ -f $1 ]
	then
		cp $1 ${1%.template}
		sed -i '' "s/{{USER}}/$USER/" $CURRENTDIR/${1%.template}
		remove_or_backup $2
		ln -s $CURRENTDIR/${1%.template} $2
	fi
}

function install_template_as_root {
	if [ -f $1 ]
	then
		cp $1 ${1%.template}
		sed -i '' "s/{{USER}}/$USER/" $CURRENTDIR/${1%.template}

		if [ -h $2 ]
		then
			sudo rm $2
		else
			if [ -f $2 ]
			then
				sudo mv $2 $2.old
			fi
		fi

		sudo ln -s $CURRENTDIR/${1%.template} $2
	fi
}




#########################################
# Methods by Dave Lens
#########################################

function lowercase()
{
	if [ -n "$1" ]; then
		echo "$1" | tr "[:upper:]" "[:lower:]"
	else
	    cat - | tr "[:upper:]" "[:lower:]"
	fi
}

# Accepts a bunch of anchor links and downloads the first matching file
# Example: download_dmg "$(curl -s http://www.alfredapp.com | grep '.dmg')" ~/Downloads/alfred.dmg
function download_dmg {
	if [[ -n $1 ]]
	then
		if [[ -n $2 ]]
		then
			wget -O $2 $(echo -e $1 | grep -o '<a href=["'"'"'][^"'"'"']*["'"'"']' | sed -e 's/^<a href=["'"'"']//' -e 's/["'"'"']$//' | sed 's/\&amp;/\&/g' | head -1)
		else
			wget $(echo -e $1 | grep -o '<a href=["'"'"'][^"'"'"']*["'"'"']' | sed -e 's/^<a href=["'"'"']//' -e 's/["'"'"']$//' | sed 's/\&amp;/\&/g' | head -1)
		fi
	fi
}
