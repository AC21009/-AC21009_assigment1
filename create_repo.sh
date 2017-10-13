#!/bin/bashecho


clear

if [ ! -d "$1" ] #check if valid directory
then
echo "No such directory exists. Press ENTER to continue:"
elif grep -Fxq $1 $HOME/repo_data/repo_data.txt #check if repo already exists
then
clear
echo "Repoistiry already exists. Press ENTER to continue:"
else
mkdir -p $1/backups
clear
echo $1 >> $HOME/repo_data/repo_data.txt #add path of new repo to text file
echo "Repository sucessfully created! Press ENTER to continue:"
fi

read temp
sh ./BASH_repo.sh

exit 0 
