#!/bin/bash

newcmd='[Create new password]'
input=$((echo -e $newcmd'\n'; gopass list -f) | fzf --layout=reverse --info=hidden)

[ -z "$input" ] && exit

[ "$input" == "$newcmd" ] && { gopass create; exit; }

echo 'Decrypting password...'
wl-copy --clear
printf '%s' "$(gopass show -o "$input")" | wl-copy -o
