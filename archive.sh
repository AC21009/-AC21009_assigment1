#!/bin/bashecho


clear

mkdir -p $PWD/archive # create temp directory
cp -fr $1 $PWD/archive # copy repo to be archived
tar -zcvf archive.tar.gz $PWD/archive # zip repo
cp -fr $PWD/archive.tar.gz $1 # copy zip folder to repo directory
rm -r $PWD/archive # remove temp folder
rm -r $PWD/archive.tar.gz # remove temp zip archive
echo "Repository has been archived. Press ENTER to contine:"
read temp
sh ./sub_menu2.sh $1

exit 0 
