#!/bin/sh

# This is the directory where the .git folder lives
DOTS_GIT=$HOME/.dot.git

# Get the path of all files in the repo
dotfile_paths=$(git --git-dir=$DOTS_GIT --work-tree=$HOME ls-files)

chosen="$(echo -e "$dotfile_paths" | fzf --info=hidden --layout=reverse --prompt='Edit config file > ')"

# Launch vim via bash, and make it interactive so it'll all work (trial and error)
[ -f "$chosen" ] && swaymsg exec "alacritty -e /bin/sh -ic 'nvim $chosen'"

