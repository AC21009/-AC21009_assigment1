#!/bin/bashecho


clear

cat << MENU
-------------------------------------------------
#####            REPOISITORY LIST           #####
-------------------------------------------------
MENU

cat $HOME/repo_data/repo_data.txt | while read line
do
echo $line
done

echo 0. Back
echo -------------------------------------------------

read input
if grep -Fxq $input $HOME/repo_data/repo_data.txt
then
current_repo=$input
sh ./sub_menu2.sh $current_repo
elif input==0
then
sh ./menu.sh
else
sh ./sub_menu1.sh
fi


exit 0


