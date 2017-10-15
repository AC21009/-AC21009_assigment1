#!/bin/bashecho
# John Parsons 160006092
# Douglas Parkinson 

clear

if grep -Fxq $1 $HOME/repo_data/repo_data.txt #check if repo exists
then
line_number=$(grep -nr $1 $HOME/repo_data/repo_data.txt | cut -d : -f 1) #find number of line to remove
sed -i ''$line_number'd' $HOME/repo_data/repo_data.txt #remove path of repo from text file
echo "Repository sucessfully removed! Press ENTER to continue:"
else 
echo "Repository doesn't exist. Press ENTER to continue:"
fi

read temp
sh ./BASH_repo.sh

exit 0 
