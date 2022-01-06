#!/bin/bash

input=$(gopass list -f | fzf --layout=reverse --info=hidden)
[ -z "$input" ] && exit
wl-copy --clear
printf '%s' "$(gopass show -o "$input")" | wl-copy
sleep 10
wl-copy --clear
