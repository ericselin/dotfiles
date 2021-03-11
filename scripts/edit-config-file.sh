#!/bin/bash

# Select a config file in the dotfiles repo for editing in vim.
# Will make it way easier to edit, with the added bonus of
# promoting committing config files to the repo so they can
# be easily edited!

# This is the directory where the .git folder lives
DOTS_GIT=$HOME/.dot.git

# Get the path of all files in the repo
dotfile_paths=$(/usr/bin/git --git-dir=$DOTS_GIT --work-tree=$HOME ls-files)

# -no-custom means don't allow custom input
chosen="$(echo -e "$dotfile_paths" | dmenu -i -l 10 -p 'Edit config file:')"

# Run in vim or message user
[ -f "$chosen" ] && alacritty -e vim $chosen || echo "No such file"

