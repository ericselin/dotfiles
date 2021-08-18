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
    _dot checkout
  fi;
  _dot config status.showUntrackedFiles no
fi;

_log 'Installing packages...'
sudo pacman -S --needed - < ~/.packages/explicit

_log 'Installing yay and AUR packages...'
if [[ ! $(yay -V) ]]; then
  mkdir -p ~/builds
  cd ~/builds
  git clone https://aur.archlinux.org/yay.git
  cd yay
  makepkg -si
  cd
fi
yay -S --needed - < ~/.packages/aur

_log 'Mounting backup drive...'
BACKUP_MOUNT="/backup"
# open backup drive
# this assumes that backup is defined in crypttab
sudo systemctl start systemd-cryptsetup@backup.service
# mount backup drive
sudo mount /dev/mapper/backup $BACKUP_MOUNT

_log 'Copying gpg keys...'
rclone sync -i $BACKUP_MOUNT/gnupg ~/.gnupg

_log 'Copying ssh keys...'
rclone sync -i $BACKUP_MOUNT/ssh ~/.ssh

_log 'WARN: should add ssh key to ssh-agent here'
_log 'WARN: should clone passwords here (via ssh)'
