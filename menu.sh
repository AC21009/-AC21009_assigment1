#!/bin/bashecho


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
2);;
3);;
0) clear; echo "Exiting..."; exit 0 ;;
*) sh ./menu.sh ;;
esac

exit 0 
