#!/bin/bash

input=$(gopass list -f | bemenu -p "gopass")
printf '%s' "$(gopass show -o "$input")" | wl-copy
sleep 10
wl-copy --clear
