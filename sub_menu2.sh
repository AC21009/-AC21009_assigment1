
#!/bin/bashecho

viewFile(){

cat << FILES
-------------------------------------------------
#####		    FILE LIST               #####
-------------------------------------------------
FILES

clear
ls -1 $1

read -p 'Please enter the name of the file to view: ' fileName
clear
less < $1$fileName

sh ./sub_menu2.sh $1
}

editFile(){
cat << FILES
-------------------------------------------------
#####		    FILE LIST               #####
-------------------------------------------------
FILES

clear
ls -1 $1

read -p 'Please enter the name of the file to edit: ' fileName
clear
nano $1$fileName

sh ./sub_menu2.sh $1
}

createFile(){

cat << FILES
-------------------------------------------------
#####		    FILE LIST               #####
-------------------------------------------------
FILES

clear
ls -1 $1

read -p 'Please enter the name of the file: ' fileName
clear
touch < $1$fileName

sh ./sub_menu2.sh $1
}

logChanges(){
sh logChange.sh $1
}

restoreBackup(){

cat << FILES
-------------------------------------------------
#####		    FILE LIST               #####
-------------------------------------------------
FILES

clear
ls -1 $1

read -p 'Please enter the name of the file to rollback: ' fileName
clear
sh restore_backup.sh $1 $fileName

sh ./sub_menu2.sh $1
}

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

logChanges $1
echo $1
echo -------------------------------------------------
ls -1 $1

read option
case "$option" in
1)viewFile $1;;
2)editFile $1; logChanges $1;;
3)createFile $1; logChanges $1;;
4);;
5);;
6)restoreBackup $1;;
7);;
0) clear; sh ./sub_menu1.sh ;;
*) sh ./sub_menu2.sh $1 ;;
esac 


exit 0
