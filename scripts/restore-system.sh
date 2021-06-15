#!/bin/bash

# Restore system according to dotfiles
# This script should be indepodent, so it can be run
# on an existing system as well

# Run command on dotfiles repository
_dot () {
  git --git-dir=$HOME/.dot.git/ --work-tree=$HOME $@
}

_log () {
  echo $@
}

_log 'Starting system restore'

_log 'Installing git...'
sudo pacman -Sy --needed git

if [ _dot status ]; then
  _log 'Found dotfiles repository, pulling...'
  _dot pull
else
  _log 'Dotfiles repository not found, cloning...'
  git clone --recurse-submodules --bare https://github.com/ericselin/dotfiles.git $HOME/.dot.git
  _dot checkout
  if [ $? = 0 ]; then
    echo "Checked out config";
  else
    echo "Backing up pre-existing dot files...";
    mkdir -p .dotfiles-backup
    _dot checkout 2>&1 | egrep "\s+\." | awk {'print $1'} | xargs -I{} mv {} .dotfiles-backup/{}
  fi;
  _dot config status.showUntrackedFiles no
fi;

_log 'Installing packages...'
sudo pacman -S --needed - < ~/.packages/explicit

_log 'Installing yay and AUR packages...'
mkdir -p ~/builds
cd ~/builds
git clone https://aur.archlinux.org/yay.git
cd yay
makepkg -si
yay -S --needed - < ~/.packages/aur

_log 'Setting zsh as default shell'
chsh -s /bin/zsh
