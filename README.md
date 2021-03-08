# Dotfiles

This is a repo of dotfiles, scripts and instructions for setting up a new system. It is a bare repo and should be synced to the home folder according to the [instructions here](https://www.atlassian.com/git/tutorials/dotfiles).

## Wishlist

### vscode 

- [x] css formatting
- [ ] ctrl+shift+e problem
- [ ] css variable intellisense

### vim

- [x] tabs as spaces
- [x] indent based on text automatically
- [ ] format document
- [ ] hbs / go templating syntax highlighting
- [ ] leader key?
- commands
  - select next occurence, like vscode ctrl+d

### os

- [x] screen lock
- [x] set background to #282a36
- [x] `less` navigation
- [ ] switch screen shortcut
- [ ] keepass start on login
- [x] emojis
- [x] `mutt` with gmail (exchange not possible)
- [ ] emojis in i3status
- [ ] `gh` list project cards alias
- [ ] keyboard layout switching
- [ ] Make gdrive mount work on boot
- [ ] screen brightness
- [x] workspace names
- [x] i3status colors

### pomodoro app

- [x] add i3 shortcut
- [x] remove file on kill
- [x] add i3 shortcut for killing
- [x] refresh i3status on update
- [x] nag on complete
- [ ] make notification more like a message, and dismissable with keyboard
- [ ] change font to non-ligatures

## Dvorak navigation (e.g. in `vim`)

Navigating in e.g. `vim` and `less` with a Dvorak layout is not very nice, since the navigation keys are not on the home row. In order to achieve proper navigation, just remap navigation to the home row keys. This of course means that we have to remap the now shadowed "original" key commands. Here are some thoughts on how to do this.

The home row of the right hand is H-T-N-S on Dvorak. Since we don't have the `:` on the home row, we can map these keys as navigation. So essentially switching `vim` navigation one key to the right.

- `h`: Move left (`j` on QWERTY)
- `t`: Move down (`k` on QWERTY)
- `n`: Move up   (`l` on QWERTY)
- `s`: Move rigt (`:` on QWERTY)

These keys now have to be remapped. E.g. `vim` has the "next occurence" for search under `n`. This can be remapped as `l`, as in "look for more".

`less` is remapped by creating a less key file and running `lesskey`.

## Software

### Core tools

- Themes: `dracula`
- Window manager: `i3`
- Terminal: `alacritty`
- Shell: `zsh`, configured via `oh-my-zsh`
- Browser: `firefox`

### Helpers

- Console email: `mutt`

## Logins / Password management

Logins are managed with KeePassXC. The database is stored in Google Drive and the key file copied to each device separately.

On Linux, the database file is [mounted with rclone](https://rclone.org/commands/rclone_mount/) [on login](https://devsrealm.com/cloud-computing/ubuntu/mounting-and-unmounting-cloud-storage-with-rclone-in-linux/) using a script in `~/scripts/mount-gdrive-sync.sh`. 

## Backups

### Logins

The login database should be backed up in the same way regular files are backed up. The keyfile should be backed up to a flashdrive together with the database password and instructions for unlocking in a sealed envelope in a secure location. 


