#!/bin/bash

### remove_or_backup, install, install_template, install_template_as_root are originally written by @tijsverkoyen

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

function lowercase()
{
	if [ -n "$1" ]; then
		echo "$1" | tr "[:upper:]" "[:lower:]"
	else
	    cat - | tr "[:upper:]" "[:lower:]"
	fi
}
