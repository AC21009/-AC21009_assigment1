#!/bin/bashecho
# John Parsons 160006092
# Douglas Parkinson 1600012359

log=$1"/.repo_files/log.txt"

#if there is no repo_files folder in the repo make on
test -e "$1/.repo_files/" || (mkdir "$1/.repo_files/"; chmod ug+rwx "$1/.repo_files/") 

#Make ghost copies of the repo files if there is not a ghost repo located in the repo_files
test  -e "$1/.repo_files/ghost_repo" || mkdir "$1/.repo_files/ghost_repo"

logDirectory(){
	#Check to see if changes have been made
	#If there are changes note them down in a log file
	dir=$1

	echo $dir
	if [ "$dir" != "" ]; then
		rootdir=$4
		repo="$2/$dir"
		g_repo="$3/$dir"
	else
		rootdir=$2
		repo=$2
		g_repo="$3"
	fi

	if [ -d $repo ]; then
		repo_files=$(ls "$repo")
	else
		repo_files=""
	fi

	if [ -d $g_repo ]; then
		g_repo_files=$(ls "$g_repo")
	else
		g_repo_files=""
	fi

	for f in $g_repo_files; do

		if [ ! -d "$g_repo_files/$f" ]; then
			test -e "$repo/$f" || (echo "$repo/$f [+] 0: [FILE DELETED] [$f]") >> $log
		fi
	done
	
	
	for f in $repo_files; do
		if [ ! -d "$repo/$f" ]; then
			if [ ! -e "$g_repo/$f" ]; then
				(echo "$repo/$f [+] 0: [FILE ADDED] [$f]") >> $log
				i=1
				while read line ; do
					echo $line
					(echo "$repo/$f [+] $i: $line [$f]") >> $log
					i=$(($i+1))
				done < "$repo/$f"
			fi			
		fi
	done


	for f in $repo_files; do

		if [ -d "$repo/$f" ]; then
			(logDirectory $f $repo $g_repo $rootdir)
			echo "Directory $repo/$f Dive Complete"
		else
			test ! -e "$repo/$f" || sort "$repo/$f" > "$rootdir/.repo_files/.repoSort"
		fi
	
		for f_ghost in $g_repo_files; do

			if [ -d "$g_repo/$f_ghost" ]; then
				(logDirectory $f_ghost $repo $g_repo $rootdir)
			else
				
				if [ "$f" = "$f_ghost" ]; then

					test ! -e "$g_repo/$f_ghost" || sort "$g_repo/$f_ghost" > "$rootdir/.repo_files/.g_repoSort"			
					
					#lines added since last commit
					comm -23 "$rootdir/.repo_files/.repoSort" "$rootdir/.repo_files/.g_repoSort" > "$rootdir/.repo_files/.repoCompare"
					while read line; do
						i=1
						while read l; do
							if [ "$l" = "$line" ]; then
								(echo "$repo/$f [+] $i: $line [$f]") >> $log
							fi
							i=$(($i+1))
						done < "$repo/$f"
					done < "$rootdir/.repo_files/.repoCompare"
		
					#lines removed since last commit
					comm -13 "$rootdir/.repo_files/.repoSort" "$rootdir/.repo_files/.g_repoSort" > "$rootdir/.repo_files/.repoCompare"
					while read line; do
						i=1
						while read l; do
							if [ "$l" = "$line" ]; then
								(echo "$repo/$f [-] $i: $line [$f]") >> $log
							fi
							i=$(($i+1))
						done < "$g_repo/$f_ghost"
					done < "$rootdir/.repo_files/.repoCompare"
				fi
			fi
		done
	done

	
	if [ -d "$repo" ] || [ -d "$g_repo" ]; then
		if [ ! -d "$g_repo" ] && [ -d "$repo" ] ; then
			(echo "$repo [+] 0: [DIRECTORY ADDED] [$(basename $repo)]") >> $log
		elif [ ! -d "$repo" ] && [ -d "$g_repo" ] ; then
			(echo "$repo [+] 0: [DIRECTORY DELETED] [$(basename $repo)]") >> $log
		fi
	fi
}

#Main Code#

logDirectory "" "$1" "$1/.repo_files/ghost_repo"

(sort -u $log) >> "$1/.repo_files/sortedLog.txt"
mv "$1/.repo_files/sortedLog.txt" "$1/.repo_files/log.txt"
