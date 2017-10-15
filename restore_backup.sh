#!/bin/bashecho
# John Parsons 160006092
# Douglas Parkinson 

clear

if [ ! -f "$1"/backups/"$2" ] #check if backup exists
then
echo "No backup found. Press ENTER to continue:"
else
cp -fr $1/backups/$2 $1
echo "Backup sucessfully restored! Press ENTER to continue:"
fi

read temp
sh ./sub_menu2.sh $1

exit 0 
