#!/bin/sh
setxkbmap -I$HOME/.xkb scandi-dvorak -print | xkbcomp -I$HOME/.xkb - :0
