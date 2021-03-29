# Dotfiles

This is a repo of dotfiles, scripts and instructions for setting up a new system. It is a bare repo and should be synced to the home folder according to the [instructions here](https://www.atlassian.com/git/tutorials/dotfiles).

It is also an attempt at creating the perfect Linux configurtion. Perfect for me, of course.

This is all written mainly for myself, or more specifically a future version of myself (hi there, me!).

## Installation

```
curl -L https://git.io/JYeUL | /bin/bash
```

The short link above links to `scripts/clone-dotfiles.sh`. It will clone this repo as a bare repo, backing up any existing files in the process.

- TODO install: add (recursive) submodule cloning
- TODO install: create proper (indepodent) installer that installs with pacman and sets up everything
- TODO install: add oh-my-zsh as a submodule

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

**vim-go** for Go HTML template syntax highlighting (currently works with HTML files inside directories named "layouts").

#### Key combos and shortcuts

Use the [vim Dvorak cheat sheet](https://www.smt.io/files/vim_cheat_sheet_for_programmers_print_DV.pdf) from @smt.

Using `vim` should come naturally and with muscle memory (at some point). This means that keyboard shortcuts will become part of the "flow", so there's really no need to keep a list of things I use every day here. So only keep things here until they come naturally.

- Remember `I` is insert at beginning of line, `A` append at end.
- Select next occurence (like vscode ctrl+d): this is the `gn` pattern, i.e. search, then `cgn` to change, and `.` to repeat.
- In visual block mode, insert on multiple lines with `I` (append with `A`).

### `sway` - a wayland window manager for hackers

`sway` is a tiling window manager, which is *really* what you want. Some things to set up and note:

- **Screen locking** can be done by running `i3-lock`.
- **Desktop background** is not really handled by i3, because the background is the root X window. Set it with `xsetroot`.
- **Workspace renaming** is easy and set up with a simple input command (might switch this from `i3-input` to `dmenu`/`rofi`).
- **Status bar** in use is `i3status` and can be configured quite well.

Things that should still be done:

- TODO sway: Screen brightness keybinding: make a binding similar to the volume controls, and create a wrapper script around the screen brightness file (in /usr?) - this requires an udev rule to add write permissions for regular users
- TODO swaybar: Add support for nicer looking emojis
- TODO sway: create locking with idle lock as well

### `bemenu` - menus for everything

Currently, `bemenu` is in use for launching apps. It is minimal, which is great, and can be used for many things. `wofi` is more extensible and has more "stuff", e.g. plugins for searching the web from within rofi and selecting emojis.

For editing files in this repo, there is now a Win+c shortcut that opens up a menu of committed files for editing in vim.

Things that would be pretty awesome to implement in the menu, coupled with an `sway` keyboard shortcut:

- TODO bemenu: Switch monitor
- TODO bemenu: Emoji picker

### `Firefox` - the developer browser

Firefox is pretty darn nice, and is not created by a huge advertising conglomerate. Some things to note:

- Firefox and Google Chrome behave differently, so **remember to test pages also in Chrome**.
- The new tab background is always white, but the "Firefox Homepage" uses a themed color. Luckily, that can be made blank by turning off all of its features. This way you get a blank new tab which is not white.

### `GitHub CLI` - manage GitHub repos with ease

`gh` is awesome! Need to use this all the time. It currently doesn't support projects, but querying the API for project info is possible indeed.

There is a custom alias `gh headless` that gets project issues from `reima-ecom`. See the config file for details.

### `Arch Linux` - minimalistic Linux with a huge community

Arch Linux is pretty cool, check it out. It requires some setup, though. Things to still implement:

- TODO os: Make udev rule to switch to work monitor when connected.
- TODO os: Make udev rule to switch to laptop monitor when any external screen is disconnected.
- TODO os: Make gdrive mount work on boot (or create startup script for mount and keepassxc).
- TODO os: configure / research copy-paste between alacritty and e.g. firefox, and within alacritty same or different windows
- TODO os: mount efi images to /boot for easy upgradability
- TODO os: enable audio via pactl

## Other tools and custom scripts

### `gopass` - gpg and pass based password manager

This password manager is pretty cool, based on GPG-encrypted files and compatible with [pass](https://www.passwordstore.org/).

- TODO gopass: install
- TODO gopass: import keepass passwords

### `keepassxc` - secure password manager

Keepass is open source, and it can be made very secure. Also, it's recommended by the EFF. The setup is currently that the database is stored in Google Drive, and synced with `rclone`. There is a key file for the database, which has not and will not touch the network.

KeePass works nicely now, but I'm in the process of migrating to gopass (see above).

### `mutt` - email in the console

Gmail is set up with an app password, and the Dracula theme is enabled. Unfortunately, it still takes a while for `mutt` to connect to the IMAP folder and load everything, and this would be great to improve on. Maybe create a local copy of the inbox? Also, Office365 doens't work currently, but might be possible. In any case, see [Jonathan's setup](https://jonathanh.co.uk/blog/mutt-setup.html) for inspiration.

### `scripts/pomodoro.sh` - pomodoro app for i3status

This script will create a file `~/pomodoro` with a ascii progress bar. This file can then be read by `i3status` to output the bar. The following features are implemented:

- Start pomodoro with the `Win-p` keyboard shortcut
- Stop pomodoro with the `Win-Shift-P` keyboard shortcut (intercepts the SIGINT and removes the file)
- Refresh i3status on update via the SIGUSR1 signal
- Notify user of pomodoro completion with `i3-nagbar`

Still to be done:

- TODO pomodoro: Make notification more like a message, and dismissable with keyboard
- TODO pomodoro: Change `i3status` font to non-ligatures so the progress bar looks nicer

## Dvorak 

Dvorak is pretty great. It has made my coding much more productive, because common keys like `/` and `[` are much more accessible than with a Finnish or Swedish keyboard. Also, it's much easier on the hands, I think. The problem is that some things don't work as well, since much of computing has been created around the QWERTY layout. Here are some thoughts for remedying those.

### International characters

One might of course switch keyboard layouts completely (to a international QWERTY version) when writing with international characters. But this is not nice. I'd rather have Dvorak with just the characters I need. The best solution is to have `ö` and the likes under `a`, `o` and `e` with an AltGr modifier.

This can be (and has now been) accomplished by manually editing the symbol map for us dvorak under `/usr/share/X11/xkb/symbols/us`. The symbols under "dvorak" shold be edited for the appropriate keys with level 3 and 4 symbols matching the international characters. However, it is also possible to extend a layout by including the original layout and making some changes. This is exactly what has been done in the "layout" named "scandi-dvorak" in `.xkb/symbols`. It is applied with `scripts/set-scandi-dvorak.sh`.

For reference, see:
- https://www.linux.com/news/extending-x-keyboard-map-xkb/
- https://www.x.org/wiki/XKB/

### Navigation (e.g. in `vim`)

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
  - Window manager: `sway`
  - Terminal: `alacritty`
  - Shell: `zsh`, configured via `oh-my-zsh`
  - Browser: `firefox`

### Helpers

  - Console email: `mutt`

## Backups

### Logins

The login database should be backed up in the same way regular files are backed up. The keyfile should be backed up to a flashdrive together with the database password and instructions for unlocking in a sealed envelope in a secure location.

- TODO backup: gopass GPG keys
