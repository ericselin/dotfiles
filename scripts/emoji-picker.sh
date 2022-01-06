#!/bin/bash

# Original from Luke Smith:
# https://github.com/LukeSmithxyz/voidrice/blob/master/.local/bin/dmenuunicode
# The famous "get a menu of emojis to copy" script.

# Get user selection via dmenu from emoji file.
chosen=$(cut -d ';' -f1 ~/scripts/emoji | fzf --layout=reverse --info=hidden)

# Exit if none chosen.
[ -z "$chosen" ] && exit
chosen=$(echo "$chosen" | sed "s/ .*//")

echo -n $chosen | wl-copy
