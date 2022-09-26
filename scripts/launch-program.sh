#!/bin/bash
compgen -c | sort -u \
| fzf --info=hidden --layout=reverse --prompt="Execute program > " \
| xargs -r swaymsg -t command exec
