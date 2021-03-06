# Dotfiles

This is a repo of dotfiles, scripts and instructions for setting up a new system. It is a bare repo and should be synced to the home folder according to the [instructions here](https://www.atlassian.com/git/tutorials/dotfiles).

## Wishlist

### vscode 

- [x] css formatting
- [ ] ctrl+shift+e problem
- [ ] css variable intellisense

### vim

- [x] tabs as spaces
- [ ] coc config
- [x] indent based on text automatically

### os

- [x] screen lock
- [x] set background to #282a36
- [ ] `less` navigation
- [ ] emojis
- [ ] `mutt` with gmail and exchange
- [ ] `gh` list project cards alias
- [ ] keyboard layout switching
- [ ] Make gdrive mount work on boot
- [ ] screen brightness
- [x] workspace names
- [x] i3status colors

### pomodoro app

- [ ] remove file on kill
- [ ] nag on complete
- [ ] change font to non-ligatures

## Dvorak navigation (e.g. in `vim`)

Navigating in e.g. `vim` and `less` with a Dvorak layout is not very nice, since the navigation keys are not on the home row. In order to achieve proper navigation, just remap navigation to the home row keys. This of course means that we have to remap the now shadowed "original" key commands. Here are some thoughts on how to do this.

The home row of the right hand is H-T-N-S on Dvorak. Since we don't have the `:` on the home row, we can map these keys as navigation. So essentially switching `vim` navigation one key to the right.

- `h`: Move left (`j` on QWERTY)
- `t`: Move down (`k` on QWERTY)
- `n`: Move up   (`l` on QWERTY)
- `s`: Move rigt (`:` on QWERTY)

These keys now have to be remapped. E.g. `vim` has the "next occurence" for search under `n`. This can be remapped as `l`, as in "look for more".

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


