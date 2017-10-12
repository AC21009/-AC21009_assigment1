#!/bin/bashecho


clear

if grep -Fxq $1 $HOME/repo_data/repo_data.txt #check if repo exists
then
sed -i '/'$1'/d' $HOME/repo_data/repo_data.txt #remove path of repo from text file
echo "Repository sucessfully removed! Press ENTER to continue:"
else 
echo "Repository doesn't exist. Press ENTER to continue:"
fi

read temp
sh ./BASH_repo.sh

exit 0 
