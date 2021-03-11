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
- In visual block mode, insert on multiple lines with `I` (append with `A`).

### `i3` - a window manager for hackers

`i3` is a tiling window manager, which is *really* what you want. Some things to set up and note:

- **Screen locking** can be done by running `i3-lock`.
- **Desktop background** is not really handled by i3, because the background is the root X window. Set it with `xsetroot`.
- **Workspace renaming** is easy and set up with a simple input command (might switch this from `i3-input` to `dmenu`/`rofi`).
- **Status bar** in use is `i3status` and can be configured quite well.

Things that should still be done:

- [ ] i3: Screen brightness keybinding: make a binding similar to the volume controls, and create a wrapper script around the screen brightness file (in /usr?) - this requires an udev rule to add write permissions for regular users
- [ ] i3status: Add support for nicer looking emojis

### `dmenu` and `rofi` - menus for everything

Currently, `dmenu` is in use for launching apps. It is minimal, which is great, and can be used for many things. `rofi` is more extensible and has more "stuff", e.g. plugins for searching the web from within rofi and selecting emojis.

Things that would be pretty awesome to implement in the menu, coupled with an `i3` keyboard shortcut:

- Keyboard layout switcher
- Switch monitor
- Emoji picker

### `Firefox` - the developer browser

Firefox is pretty darn nice, and is not created by a huge advertising conglomerate. Some things to note:

- Firefox and Google Chrome behave differently, so **remember to test pages also in Chrome**.
- The new tab background is always white, but the "Firefox Homepage" uses a themed color. Luckily, that can be made blank by turning off all of its features. This way you get a blank new tab which is not white.

### `GitHub CLI` - manage GitHub repos with ease

`gh` is awesome! Need to use this all the time. It currently doesn't support projects, but querying the API for project info is possible indeed.

Make it awesome:

- [ ] gh: Create a `gh` alias for getting project cards.

### `Arch Linux` - minimalistic Linux with a huge community

So in reality I'm running Ububntu at the moment. Should switch to Arch, though, as it's not bloated like Ubuntu, has pretty awesome documentation and community, and the AUR package repository seems way better.

Things to implement in the OS in any case:

- [ ] os: Make udev rule to switch to work monitor when connected.
- [ ] os: Make udev rule to switch to laptop monitor when any external screen is disconnected.
- [ ] os: Make gdrive mount work on boot (or create startup script for mount and keepassxc).

## Other tools and custom scripts

### `keepassxc` - secure password manager

Keepass is open source, and it can be made very secure. Also, it's recommended by the EFF. The setup is currently that the database is stored in Google Drive, and synced with `rclone`. There is a key file for the database, which has not and will not touch the network.

### `mutt` - email in the console

Gmail is set up with an app password, and the Dracula theme is enabled. Unfortunately, it still takes a while for `mutt` to connect to the IMAP folder and load everything, and this would be great to improve on. Maybe create a local copy of the inbox? Also, Office365 doens't work currently, but might be possible. In any case, see [Jonathan's setup](https://jonathanh.co.uk/blog/mutt-setup.html) for inspiration.

### `scripts/pomodoro.sh` - pomodoro app for i3status

This script will create a file `~/pomodoro` with a ascii progress bar. This file can then be read by `i3status` to output the bar. The following features are implemented:

- Start pomodoro with the `Win-p` keyboard shortcut
- Stop pomodoro with the `Win-Shift-P` keyboard shortcut (intercepts the SIGINT and removes the file)
- Refresh i3status on update via the SIGUSR1 signal
- Notify user of pomodoro completion with `i3-nagbar`

Still to be done:

- [ ] pomodoro: Make notification more like a message, and dismissable with keyboard
- [ ] pomodoro: Change `i3status` font to non-ligatures so the progress bar looks nicer

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

