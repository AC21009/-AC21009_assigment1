#!/bin/bashecho
# John Parsons 160006092
# Douglas Parkinson 

clear
echo $2
test -e "$HOME/repo_data/$(basename $1)/backups/archive.tar.gz" && ( tar -zxvf "$HOME/repo_data/$(basename $1)/backups/archive.tar.gz" -C "$HOME/repo_data/$(basename $1)/backups/" ) #Decompresses the zip file for reading
clear
archivePath="$HOME/repo_data/$(basename $1)/backups/archive"
if [ ! -f "$HOME/repo_data/$(basename $1)/backups/$archivePath/$(basename $1)/$2" ] #check if backup exists
then
	echo "No backup found. Press ENTER to continue:"
else
	cp -fr "$HOME/repo_data/$(basename $1)/backups/$archivePath/$(basename $1)/$2" "$1"
	rm -r "$HOME/repo_data/$(basename $1)/backups/home"
	echo "Backup sucessfully restored! Press ENTER to continue:"
fi

read temp
sh ./sub_menu2.sh $1

exit 0
