#!/bin/bash

cd "$1"

cmd="$(find . -type f -executable -printf '%P\n' | fzf --layout=reverse --info=hidden --prompt='Run > ')"

[ -z "$cmd" ] && exit

"./$cmd"