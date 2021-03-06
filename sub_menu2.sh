#!/bin/bashecho
# John Parsons 160006092
# Douglas Parkinson 1600012359

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
less "$1/$fileName"

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

dirName="$(basename $1)"
read -p 'Please enter the name of the file to edit: ' fileName
cp -f $1/$fileName $HOME/repo_data/$dirName/backups #backup file before editing
clear
nano "$1/$fileName"

logChanges $1
clear
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
touch "$1/$fileName"

logChanges $1
clear
sh ./sub_menu2.sh $1
}

deleteFile(){
cat << FILES
-------------------------------------------------
#####		    FILE LIST               #####
-------------------------------------------------
FILES

clear
ls -1 $1

read -p 'Please enter the name of the file: ' fileName
clear
rm -R "$1/$fileName"

	logChanges $1
	clear
	sh ./sub_menu2.sh $1
}

viewLog(){
	logChanges $1
	clear
	echo "#####	[LOCAL] log.txt		#####"
	echo ""
	cat "$1/.repo_files/log.txt"
	echo ""
	echo "#####	[GLOBAL] commit_log.txt		#####"
	echo ""
	cat "$1/.repo_files/commit_log.txt"
	echo ""
	read -p 'Log End: Please press enter to continue.' temp

	sh ./sub_menu2.sh $1
}

commitRepo(){
	logChanges $1
	clear
	rm -R "$1/.repo_files/ghost_repo"
	rsync -av --exclude=".*" "$1" "$1/.repo_files/"
	mv "$1/.repo_files/$(basename $1)" "$1/.repo_files/ghost_repo"
	echo "####	COMMIT	####" >> "$1/.repo_files/commit_log.txt"
	cat "$1/.repo_files/log.txt" >> "$1/.repo_files/commit_log.txt"
	echo "####	COMMITEND	####" >> "$1/.repo_files/commit_log.txt"
	cat "$1/.repo_files/commit_log.txt"
	> "$1/.repo_files/log.txt"
	
	clear
	sh ./sub_menu2.sh $1
}

compileCode(){
cat << FILES
-------------------------------------------------
#####		    FILE LIST               #####
-------------------------------------------------
FILES

clear
ls -1 $1

read -p 'Please enter the name of the file you want to compile: ' fileName
read - p 'Please enter the file names of any dependencies for the file you want to compile with a space between each one: ' fileDepends
clear

set -f
depends=${"fileDepends"// /}

for i in depends; do
	${depends[$i]}="$1/${depends[$i]}"
done

gcc -o "$filename_compiled" -Wall $(eval $(ls $depends))

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

logChanges $1

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
8. Archive Repo
9. Commit Repo
0. Back
-------------------------------------------------
MENU

echo $1
echo -------------------------------------------------
ls -1 $1

read option
case "$option" in
1)viewFile $1;;
2)editFile $1;;
3)createFile $1;;
4)deleteFile $1;;
5)viewLog $1;;
6)restoreBackup $1;;
7)compileCode $1;;
8)sh ./archive.sh $1;;
9)commitRepo $1;;
0) clear; sh ./sub_menu1.sh;;
*) sh ./sub_menu2.sh $1 ;;
esac 


exit 0
