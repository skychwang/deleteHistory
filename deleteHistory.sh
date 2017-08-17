#!/bin/sh

DIR="${BASH_SOURCE%/*}"
if [[ ! -d "$DIR" ]]; then
	DIR="$PWD"; 
fi
source $DIR/config.cfg

if [[ "$chrome" == true ]]; then
	cd ~/Library/Application\ Support/Google/Chrome/Default/
	sqlite3 History <<EOF
	delete from urls;
	vacuum;
EOF
	echo "Google Chrome history deleted."
fi