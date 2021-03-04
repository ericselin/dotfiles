# Dotfiles

This is a repo of dotfiles, scripts and instructions for setting up a new system. It is a bare repo and should be synced to the home folder according to the [instructions here](https://www.atlassian.com/git/tutorials/dotfiles).

## TODO

vscode 
- [x] css formatting
- [ ] ctrl+shift+e problem
- [ ] css variable intellisense

os
- [ ] screen lock
- [ ] keyboard layout switching
- [ ] Make gdrive mount work on boot
- [ ] Pomodoro app
- [ ] screen brightness
- [x] workspace names
- [ ] i3status colors

## Software

- Themes: `dracula`
- Window manager: `i3`
- Terminal: `urxvt`
- Shell: `zsh`, configured via `oh-my-zsh`

## Logins / Password management

Logins are managed with KeePassXC. The database is stored in Google Drive and the key file copied to each device separately.

On Linux, the database file is [mounted with rclone](https://rclone.org/commands/rclone_mount/) [on login](https://devsrealm.com/cloud-computing/ubuntu/mounting-and-unmounting-cloud-storage-with-rclone-in-linux/) using a script in `~/scripts/mount-gdrive-sync.sh`. 

## Backups

### Logins

The login database should be backed up in the same way regular files are backed up. The keyfile should be backed up to a flashdrive together with the database password and instructions for unlocking in a sealed envelope in a secure location. 


