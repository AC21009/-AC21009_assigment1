#!/bin/bashecho


clear


cat << MENU
-------------------------------------------------
#####           REPOISITORY FILES           #####
-------------------------------------------------
1. View File
2. Edit File
3. Create File
4. Delete File
5. View Log	
6. Restore Backup
7. Compile Code
0. Back
-------------------------------------------------
MENU

echo $1

read option
case "$option" in
1) echo "yay";;
2);;
3);;
0) clear; sh ./sub_menu1.sh ;;
*) sh ./sub_menu2.sh $1 ;;
esac 


exit 0 
