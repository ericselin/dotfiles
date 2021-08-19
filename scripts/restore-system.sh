#!/bin/bash

# Restore system according to dotfiles
# This script should be indepodent, so it can be run
# on an existing system as well

_log 'Installing packages...'
sudo pacman -S --needed - < ~/.packages/explicit

_log 'Installing yay and AUR packages...'
if [[ ! $(yay -V) ]]; then
  mkdir -p ~/builds
  cd ~/builds
  git clone https://aur.archlinux.org/yay.git
  cd yay
  makepkg -sc
  sudo pacman -U yay-*.pkg.tar.zst
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

_log 'Adding ssh key to ssh-agent'
source ~/.bashrc # to make sure ssh-agent is running
ssh-add

_log 'Cloning passwords with gopass'
gopass clone ssh://git@github.com/ericselin/passwords.git
