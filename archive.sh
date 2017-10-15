#!/bin/bashecho
# John Parsons 160006092
# Douglas Parkinson 1600012359


clear

dirName="$(basename $1)"

mkdir -p "$HOME/repo_data/$dirName/backups/archive" # create temp directory
cp -fr $1 "$HOME/repo_data/$dirName/backups/archive" # copy repo to be archived
tar -zcvf "$HOME/repo_data/$dirName/backups/archive.tar.gz" "$HOME/repo_data/$dirName/backups/archive"  # zip repo
rm -r "$HOME/repo_data/$dirName/backups/archive" # remove temp folder

echo "Repository has been archived. Press ENTER to contine:"
read temp
sh ./sub_menu2.sh $1

exit 0
