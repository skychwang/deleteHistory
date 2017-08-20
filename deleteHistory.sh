#!/bin/sh

#Sourcing config file

DIR="${BASH_SOURCE%/*}"
if [[ ! -d "$DIR" ]]; then
	DIR="$PWD"; 
fi
source $DIR/config.cfg

#Chrome

if [[ "$chrome" == true ]]; then
	cd ~/Library/Application\ Support/Google/Chrome/Default/
	sqlite3 History <<EOF
	delete from urls;
	vacuum;
EOF
	echo "Google Chrome history deleted."
fi

#Safari

if [[ "$safari" == true ]]; then
	cd ~/Library/Safari
	rm History.{db,db-lock,db-shm,db-wal}
	rm WebpageIcons.{db,db-shm,db-wal}
	rm {TopSites,RecentlyClosedTabs,History}.plist
	echo "Safari history deleted."
fi

#Firefox

if [[ "$firefox" == true ]]; then
	cd ~/Library/Application\ Support/Firefox/Profiles/*/.
	if [[ "$moz_history" == true ]]; then
		sqlite3 places.sqlite <<EOF
		delete from moz_historyvisits;
		delete from moz_places;
		vacuum;
EOF
	echo "Firefox history deleted."
	fi
	if [[ "$moz_favicons" == true ]]; then
		sqlite3 places.sqlite <<EOF
		delete from moz_favicons;
		vacuum;
EOF
	echo "Firefox favicons deleted."
	fi
	if [[ "$moz_bookmarks" == true ]]; then
		sqlite3 places.sqlite <<EOF
		delete from moz_bookmarks;
		vacuum;
EOF
	echo "Firefox bookmarks deleted."
	fi
fi