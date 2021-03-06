#!/bin/bash
# Utility to create and execute session scripts

# Variables

#File Manager 
#FM=ranger
FM=cfiles

# Default tmux session
DT=~/bin/go

# Location of codemenu.sh
CM=~/scripts/codemenu.sh

# Path to project directories
CODE=/home/stephen/code

# IDE session
FILE1=~/scripts/session.sh

# Return session
FILE2=~/scripts/session2.sh

# Derived variables, don't change
# FILE2 in quotes
FILE2Q=\'$FILE2\'

# Codemenu command for tmux
CM1="$CM $CODE/$1"
CMQ=\'$CM1\'

# Creates script that creates the new session
touch $FILE2
chmod +x $FILE2
echo "#!/bin/bash" > $FILE2
echo "cd ~/code/$1" >> $FILE2
echo "tmux split-window -h" >> $FILE2
echo "tmux split-window -v $CMQ" >> $FILE2
echo "tmux resize-pane -D 16" >> $FILE2
echo "tmux resize-pane -R 35" >> $FILE2
echo "sleep 0.5" >> $FILE2 #prevents errors while openeing cfiles, not needed for ranger
echo "$FM" >> $FILE2

tmux new-session -s $1 -d $FILE2Q

touch $FILE1
echo "#!/bin/bash" > $FILE1
echo "tmux a -t $1" >> $FILE1
echo "rm $FILE1" >> $FILE1
echo "~/bin/go" >> $FILE1
chmod +x $FILE1

tmux detach
