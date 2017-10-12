#!/bin/bashecho

repo=$1
g_repo=$1".repo_files/ghost_repo/"
log=$repo".repo_files/log.txt"

#if there is no repo_files folder in the repo make on
test -e "$repo.repo_files/" || (mkdir "$repo.repo_files/"; chmod ug+rwx "$repo.repo_files/") 

#Make ghost copies of the repo files if there is not a ghost repo located in the repo_files
test  -e "$g_repo" || (mkdir "$g_repo"; chmod ug+rwx "$repo.repo_files/"; rsync -av --exclude=".*" $repo $g_repo)


#Check to see if changes have been made
#If there are changes note them down in a log file
repo_files=$(ls $repo)
g_repo_files=$(ls $g_repo)
for f in $repo_files; do

	sort "$repo$f" > "$repo.repo_files/.repoSort"

	for f_ghost in $g_repo_files; do 
		if [ "$f" = "$f_ghost" ];
		then
			sort "$g_repo$f_ghost" > "$repo.repo_files/.g_repoSort"			
			
			#lines added since last commit
			comm -23 "$repo.repo_files/.repoSort" "$repo.repo_files/.g_repoSort" > "$repo.repo_files/.repoCompare"
			while read line; do
				i=1
				while read l; do
					if [ "$l" = "$line" ]; then
						(echo "$f [+] $i: $line") >> $log
					fi
					i=$(($i+1))
				done < $repo$f
			done < "$repo.repo_files/.repoCompare"

			#lines removed since last commit
			comm -13 "$repo.repo_files/.repoSort" "$repo.repo_files/.g_repoSort" > "$repo.repo_files/.repoCompare"
			while read line; do
				i=1
				while read l; do
					if [ "$l" = "$line" ]; then
						(echo "$f [-] $i: $line") >> $log
					fi
					i=$(($i+1))
				done < $g_repo$f_ghost
			done < "$repo.repo_files/.repoCompare"
		fi
	done
done

for f in $g_repo_files; do
	test -e $repo$f || (echo "$f [+] 0: [FILE DELETED]") >> $log
done

for f in $repo_files; do
	if [ ! -e $g_repo$f ]; then
		(echo "$f [+] 0: [FILE ADDED]") >> $log
		i=1
		while read line ; do
			echo $line
			(echo "$f [+] $i: $line") >> $log
			i=$(($i+1))
		done < "$repo$f"
	fi
done

(sort -u $log) >> "$repo.repo_files/sortedLog.txt"
mv "$repo.repo_files/sortedLog.txt" "$repo.repo_files/log.txt"
