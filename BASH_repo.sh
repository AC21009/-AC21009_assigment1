#!/bin/bashecho
# John Parsons 160006092
# Douglas Parkinson 1600012359

mkdir -p $HOME/repo_data
test -e $HOME/repo_data/repo_data.txt || touch $HOME/repo_data/repo_data.txt
sh ./menu.sh 

exit 0
