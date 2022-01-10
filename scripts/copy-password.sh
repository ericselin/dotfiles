#!/bin/bash

input=$(gopass list -f | fzf --layout=reverse --info=hidden)
[ -z "$input" ] && exit
echo 'Decrypting password...'
wl-copy --clear
printf '%s' "$(gopass show -o "$input")" | wl-copy -o
