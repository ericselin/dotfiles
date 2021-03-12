#!/bin/bash

# This is the directory where the .git folder lives
DOTS_GIT=$HOME/.dot.git

# Get the path of all files in the repo
dotfile_paths=$(/usr/bin/git --git-dir=$DOTS_GIT --work-tree=$HOME ls-files)

chosen="$(echo -e "$dotfile_paths" | dmenu -i -l 10 -p 'Edit config file:')"

# Launch vim via bash, and make it interactive so it'll all work (trial and error)
[ -f "$chosen" ] && alacritty -e /bin/bash -ic "vim $chosen" || dunstify "No such file"

