#!/bin/sh

# Because an additional directory is included, we need to run this
# in two steps: setxkbmap and xkbcomp separately. Otherwise the implicit
# xkbcomp step doesn't know about the additional dir. This is like what
# is described in the setxkbmap man page about client/server.

setxkbmap -I$HOME/.xkb scandi-dvorak -print | xkbcomp -I$HOME/.xkb - :0
