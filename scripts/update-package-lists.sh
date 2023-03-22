#!/usr/bin/env bash

# Update list of packages in home directory

# Explicit official (not "foreign")
pacman -Qqen > ~/.packages/explicit
# AUR ("foreign")
pacman -Qqem > ~/.packages/aur
# Dotfiles repo commit and push
git --git-dir=$HOME/.dot.git/ --work-tree=$HOME add ~/.packages
git --git-dir=$HOME/.dot.git/ --work-tree=$HOME commit -m 'Updated installed packages list'
git --git-dir=$HOME/.dot.git/ --work-tree=$HOME push
