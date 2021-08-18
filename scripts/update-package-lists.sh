#!/bin/bash

# Update list of packages in home directory

# Explicit official (not "foreign")
pacman -Qqentt > ~/.packages/explicit
# AUR ("foreign")
pacman -Qqemtt > ~/.packages/aur
# Dotfiles repo commit and push
git --git-dir=$HOME/.dot.git/ --work-tree=$HOME add ~/.packages
git --git-dir=$HOME/.dot.git/ --work-tree=$HOME commit -m 'Updated installed packages list'
git --git-dir=$HOME/.dot.git/ --work-tree=$HOME push
