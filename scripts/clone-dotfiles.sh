#!/bin/bash

# Clone dotfiles repository as a bare repo in the home directory

# Run command on dotfiles repository
_dot () {
  git --git-dir=$HOME/.dot.git/ --work-tree=$HOME $@
}

echo 'Starting system restore'

echo 'Installing git...'
sudo pacman -Sy --needed git

if _dot status; then
  echo 'Found dotfiles repository, pulling...'
  _dot pull
else
  echo 'Dotfiles repository not found, cloning...'
  git clone --bare https://github.com/ericselin/dotfiles.git $HOME/.dot.git
  _dot checkout
  if [ $? = 0 ]; then
    echo "Checked out config";
  else
    echo "Backing up pre-existing dot files...";
    mkdir -p .dotfiles-backup
    _dot checkout 2>&1 | egrep "\s+\." | awk {'print $1'} | xargs -I{} mv {} .dotfiles-backup/{}
    _dot checkout
  fi;
  _dot config status.showUntrackedFiles no
fi;

echo 'Cloning submodules...'
_dot submodule update --init --recursive
