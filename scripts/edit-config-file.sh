#!/bin/bash

# This is the directory where the .git folder lives
DOTS_GIT=$HOME/.dot.git

# Get the path of all files in the repo
dotfile_paths=$(/usr/bin/git --git-dir=$DOTS_GIT --work-tree=$HOME ls-files)

# -no-custom means don't allow custom input
chosen="$(echo -e "$dotfile_paths" | dmenu -i -l 10 -p 'Edit config file:')"

[ -f "$chosen" ] && alacritty -e /bin/sh -lc "vim $chosen" || dunstify "No such file"

