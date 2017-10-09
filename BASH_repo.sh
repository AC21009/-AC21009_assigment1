#!/bin/bashecho


mkdir -p $HOME/repo_data
test $HOME/repo_data/repo_data.txt || touch $HOME/repo_data/repo_data.txt
sh ./menu.sh 

exit 0
