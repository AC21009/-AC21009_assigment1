#!/bin/bashecho
# John Parsons 160006092
# Douglas Parkinson 1600012359

clear
dirName="$(basename $1)"

if [ ! -f "$HOME"/repo_data/"$dirName"/backups/"$2" ] #check if backup exists
then
echo "No backup found. Press ENTER to continue:"
else
cp -fr $HOME/repo_data/$dirName/backups/$2 $1
echo "Backup sucessfully restored! Press ENTER to continue:"
fi

read temp
sh ./sub_menu2.sh $1

exit 0 
