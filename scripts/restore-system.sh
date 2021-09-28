#!/bin/bash

# Restore system according to dotfiles
# This script should be indepodent, so it can be run
# on an existing system as well

# mount backup drive if not already mounted
# this is needed in order to restore ssh and gpg keys
BACKUP_MOUNT="/backup"
if [ -f "$BACKUP_MOUNT/.backup_drive" ]; then
  echo 'Backup drive already mounted'
else
  echo 'Mounting backup drive...'
  # open backup drive
  # this assumes that backup is defined in crypttab
  sudo systemctl start systemd-cryptsetup@backup.service
  # mount backup drive
  sudo mount /dev/mapper/backup $BACKUP_MOUNT
fi

# run scripts in backup.d with the restore option
run-parts ~/scripts/backup.home.d --arg=restore
