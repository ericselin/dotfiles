# Dotfiles

This is a repo of dotfiles, scripts and instructions for setting up a new system. It is a bare repo and should be synced to the home folder according to the [instructions here](https://www.atlassian.com/git/tutorials/dotfiles).

It is also an attempt at creating the perfect Linux configurtion. Perfect for me, of course.

This is all written mainly for myself, or more specifically a future version of myself (hi there, me!).

## Development

Development of documentation and configuration should follow sane development practices as much as possible. Try to commit early and often, use feature branches where applicable, and conventional commits. Try to commit one "feature" or "bug fix" at a time. All config files that matter (that have been edited) should be included in this repo.

## Core tools

These are the most important components of the setup.

### `vim` - simple but powerful edtor

I use `vim` as my main editor and IDE. VSCode is great, but this is more minimal and more Linux-y. This is an experiment for now, but I anticipate productivity to go up significantly. Below are some thoughts on how to do certain things. Remember, the config file can be found in this repo, and it should be commented to explain the things I want `vim` to do for me.

For inspiration, see also:
- https://hackernoon.com/how-to-use-vim-for-frontend-development-2020-edition-dac83yyh

#### Plugins

**Dracula theme** is used everywhere, also in `vim`.

**Coc** for language server integration. Use setup instructions at deno.land to get Deno working nicely. E.g. `:CocCommand deno.initializeWorkspace`.

**Airline** for a nice status line (of course themed with Dracula).

**Emmet** for quickly adding HTML tags. Enabled only for HTML files.

**CtrP** for quickly opening files within the workspace. Select a file and press `<C-t>` to open in a new tab.

**TODO: go-vim** for syntax highlighting go templates, which are used by `hugo`.

#### Key combos and shortcuts

Use the [vim Dvorak cheat sheet](https://www.smt.io/files/vim_cheat_sheet_for_programmers_print_DV.pdf) from @smt.

Using `vim` should come naturally and with muscle memory (at some point). This means that keyboard shortcuts will become part of the "flow", so there's really no need to keep a list of things I use every day here. So only keep things here until they come naturally.

- Remember `I` is insert at beginning of line, `A` append at end.
- Select next occurence (like vscode ctrl+d): this is the `gn` pattern, i.e. search, then `cgn` to change, and `.` to repeat.

### os

- [ ] rofi, in particular search
- [x] screen lock
- [x] set background to #282a36
- [x] `less` navigation
- [ ] switch screen shortcut / udev rule!
- [x] firefox blank bg
this can be done with the firefox home and disabling everything
- [ ] firefox vim bindings
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

