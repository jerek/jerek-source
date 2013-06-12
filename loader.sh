#!/bin/bash

# Script: Jerek Source
# Author: Jerek Dain
# Email:  jerek@jerek.net
# Description: A Bash script to source a series of shell scripts from organized subdirectories.
#
# Installation:
# git clone git@github.com:jerek/jerek-source.git ~/.jereksource
#
# Example usage: Add the following two lines to your .bashrc:
# source ~/.jereksource/loader.sh
# jerekSource 'env:local;tools:misc,git/common,vagrant;sites:main'
#
# That would source:
# ~/.jereksource/autoload/*
# ~/.jereksource/env/local
# ~/.jereksource/tools/misc
# ~/.jereksource/tools/git/common
# ~/.jereksource/tools/vagrant
# ~/.jereksource/sites/main
#
# Files in ~/.jereksource/autoload will always be sourced, and sourced first.
# Files to be sourced MUST exist at least 1 level within the directory holding this script. ( ~/.jereksource in the example usage above. )

jerekSource() {
	# Get script directory
	JS_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"

	# Auto source everything in ./autoload
	JS_AUTOLOAD=$JS_DIR/autoload/*
	for file in $JS_AUTOLOAD; do
		if [ -f $file ]; then
			source $file
		fi
	done

	# Source everything specifically requested
	while IFS=';' read -ra JS_GROUPS; do
		for JS_GROUP in "${JS_GROUPS[@]}"; do
			IFS=':' read -ra JS_GROUPDETAILS <<< "$JS_GROUP"
			while IFS=',' read -ra JS_FILES; do
				for JS_FILE in "${JS_FILES[@]}"; do
					if [ -f $JS_DIR/${JS_GROUPDETAILS[0]}/$JS_FILE ]; then
						source $JS_DIR/${JS_GROUPDETAILS[0]}/$JS_FILE
					else
						echo "Jerek Source: Requested file \"$JS_DIR/${JS_GROUPDETAILS[0]}/$JS_FILE\" does not exist."
					fi
				done
			done <<< "${JS_GROUPDETAILS[1]}"
		done
	done <<< "$1"
}
