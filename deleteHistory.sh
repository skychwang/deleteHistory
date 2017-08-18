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

if [[ "$safari" == true ]]; then
	cd ~/Library/Safari
	rm History.{db,db-lock,db-shm,db-wal}
	rm WebpageIcons.{db,db-shm,db-wal}
	rm {TopSites,RecentlyClosedTabs,History}.plist
	echo "Safari history deleted."
fi