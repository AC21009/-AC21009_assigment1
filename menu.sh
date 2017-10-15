#!/bin/bashecho
# John Parsons 160006092
# Douglas Parkinson 160012359

clear
cat << MENU
-------------------------------------------------
#####    WELCOME TO BASH REPOISITORY 1.0    #####
-------------------------------------------------
1. Access Repository
2. Create Repository
3. Remove Repository
0. Exit
-------------------------------------------------
MENU

read option
case "$option" in
1) sh ./sub_menu1.sh ;;
2) echo "Enter the path of the directory you wish to be under version control:"; read input; sh create_repo.sh $input ;;
3)echo "Enter the path of the repository you wish to no longer be under version control:"; read input; sh remove_repo.sh $input ;;
0) clear; echo "Exiting..."; exit 0 ;;
*) sh ./menu.sh ;;
esac

exit 0 
