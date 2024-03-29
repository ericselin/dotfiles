#!/usr/bin/env bash

cd "$1"

cmd="$(find . -type f -executable -printf '%P\n' | fzf --layout=reverse --info=hidden --prompt='Run > ')"

[ -z "$cmd" ] && exit

"./$cmd"

if [ $? -gt 0 ]; then
echo
read -p 'Press any key to exit...'
fi