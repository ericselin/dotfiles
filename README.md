# Dotfiles

This is a repo of dotfiles, scripts and instructions for setting up a new system. It is a bare repo and should be synced to the home folder according to the [instructions here](https://www.atlassian.com/git/tutorials/dotfiles).

It is also an attempt at creating the perfect Linux configurtion. Perfect for me, of course.

This is all written mainly for myself, or more specifically a future version of myself (hi there, me!).

## Installation

```
curl -L https://git.io/JnYvI | /bin/bash
```

The short link above links to `scripts/restore-system.sh`. It will install everything and clone this repo as a bare repo, backing up any existing files in the process.

## Environment

These are the thins that are needed in order to run things - the infrastructure as at was. Things not listed here are considered part of the system or linked to specific user stories.

### Minimalistic Linux OS - `Arch Linux`

Arch Linux is pretty cool, check it out. It requires some setup, though. This repo should help in setting everything up.

### Window manager for Wayland - `sway`

`sway` is a tiling window manager, which is *really* what you want. Setup includes:

- **Screen locking** is done via `swayidle` and `swaylock`.
- **Status bar** in use is `i3status` and can be configured quite well.

### Fast terminal with vim mode - `alacritty`

The terminal uses the `zsh` shell, with the `oh-my-zsh` plugin. This is not exclusive to alacritty, it's also enabled in the main console TTY.

### Universal menu - `bemenu`

Currently, `bemenu` is in use for launching apps. It is minimal, which is great, and can be used for many things. `wofi` is more extensible and has more "stuff", e.g. plugins for searching the web from within rofi and selecting emojis.

For editing files in this repo, there is now a Win+c shortcut that opens up a menu of committed files for editing in vim.

### Simple notifications - `mako`

Mako "just works". It is very simple, but that's how I like it.

### Dark theming - `dracula` and `Source Code Pro`

Dracula is a nice dark theme, but more than that, includes config files for setup of over a hundred apps. The font used throughout is Adobe's Source Code Pro (Fira Code doesn't work in alacritty).

### Keyboard layout for hackers - `dvorak`

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

## Best practices

### Use secure passwords - keepass -> `gopass`

Right now, `keepassxc` is in use, but it should be migrated to `gopass`. Keepass is open source, and it can be made very secure. Also, it's recommended by the EFF. The setup is currently that the database is stored in Google Drive, and synced with `rclone`. There is a key file for the database, which has not and will not touch the network.

This password manager is pretty cool, based on GPG-encrypted files and compatible with [pass](https://www.passwordstore.org/).

There is a script based on `bemenu` that searches and copies passwords. `gopass` uses `gpg`, and key passphrases are used via `gpg-agent`. Passphrases are entered via a `pinentry` program, more specifically `pinentry-gnome3`. See optional dependencies for `pinentry` for the proper dependencies for that `pinentry` backend.

#### Migration from `keypass`

Currently, passwords are stored in a `keypass` database. Keep this database alive in Google Drive, and the key file safe and backed up. Whenever a password is needed that is not in `gopass`, add it there. This should work fine for common passwords. The fate of rarer passwords should be considered in a few months, either choose what to migrate, or just keep the system as-is. Do this at the very latest after the summer.

### Back everything up (rule of three)

Every original copy of everything should live in the "cloud" (personal file share or cloud storage provider). This means e.g. Google Drive for documents, and GitHub for code. Thus, in the base case of a device failing or becoming lost, data can easily be restored from the "cloud". A basic backup setup would then be to back up everything to two external drives that rotate off-site (to work).

The backup drives of course contain everything, so those need to be encrypted. The best cross-OS block device encryption tool seems to be [VeraCrypt](https://veracrypt.fr/en/Home.html) (fork of TrueCrypt). To be safe, it seems reasonable that the backup could be read in Windows. However, right now Linux is my main OS, and installing Linux is possible if only just to recover a backup. Plus, backups are by their nature ephemeral, which means it's enough if it works now, it needn't work in a year. Bottom line: just backup with [dm-crypt](https://wiki.archlinux.org/index.php/Dm-crypt).

Below are some very WIP notes

What do I have and where:

- Passwords
  These are stored in encrypted files, see below. Keepass db in gdrive. Can be cloud-synced.
- Secret keys
  GPG and keepass keys. Should never touch the network, at least not things I don't own myself.
- Emails
  Only in gmail at the moment. Work emails can be disregarded.
- Photos
  In Google Photos, with older photos on an external HDD.
- Files
  Stuff I care about are in GDrive.
- Git repositories
  Includes personal code things, as well as e.g. this dotfile repo. These are in GitHub, with some wip things on the computer.
- Notes
  Only in Keep. Should be moved to git.
- Contacts
  On Google.
- Calendar
  On Google.
- 2FA backup codes
  On paper or non-existing.
- Bookmarks
  In Firefox or Chrome, backed up to the cloud.
- Bought music
  On external HDD.
- Verros stuff
  All of the above, basically.

Physical locations of working copies:

- Cloud: majority of data
  - gmail
  - github
  - google photos
  - google drive
  - google keep
  - google calendar
  - google contacts
  - bookmarks
- External HDD: old photos, movies, music
- Laptop/phone: GPG keys and other key files
- Paper: 2FA backup codes

How to backup

- Create a script to back everything up to a specific folder
- Phase 1: this folder is just the mount of a backup drive, copy with rclone
  - Everything that has its working copy in the cloud is safe here (one copy in the cloud, two backup drives)
- Phase 2: this folder is on a NAS, can be a sync or mount or something, to create a personal "cloud file system"

### Encrypt anything important

Encryption of the whole disk is just best for everything. No need to encrypt the boot partition, though.

### Disaster recovery

There should be a clear and tested process for disaster recovery of any important device.

## Daily drivers

Tools I need for everyday work. These are crucial and don't need a specific use case - they are the reason I have a computer in the first place.

### Simple but powerful editor - `vim`

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

### Main browser - `Firefox`

Firefox is pretty darn nice, and is not created by a huge advertising conglomerate. Some things to note:

- Firefox and Google Chrome behave differently, so **remember to test pages also in Chrome**.
- The new tab background is always white, but the "Firefox Homepage" uses a themed color. Luckily, that can be made blank by turning off all of its features. This way you get a blank new tab which is not white.

### Source control - `git` and `gh-cli`

Git is pretty self explanatory and always required.

### `GitHub CLI` - manage GitHub repos with ease

`gh` is awesome! Need to use this all the time. It currently doesn't support projects, but querying the API for project info is possible indeed.

There is a custom alias `gh headless` that gets project issues from `reima-ecom`. See the config file for details.

### Todo management - humla, gh-cli, text -> custom

Personal todos are now in humla.app. Work todos are mainly issues in GitHub, with some additions in humla. There should pretty obviously be only one source of truth, accessible from all devices. A CLI would be extremely awesome for Linux environments (possibly Deno in order to make it OS-independent). This could be coupled with note taking, which would make it easy to turn a note into a todo.

Probably best to just continue with humla, or rather, the new version of humla. It needs to include GitHub issues as well in the long term.

### Pomodoros - custom script `scripts/pomodoro.sh`

This script will create a file `~/pomodoro` with a ascii progress bar. This file can then be read by `i3status` to output the bar. The following features are implemented:

- Start pomodoro with the `Win-p` keyboard shortcut
- Stop pomodoro with the `Win-Shift-P` keyboard shortcut (intercepts the SIGINT and removes the file)
- Refresh i3status on update via the SIGUSR1 signal
- Notify user of pomodoro completion with `notify-send`

### Calendar - google -> `khal`

Calendaring should be possible through the terminal. For this, `khal` with syncing seems like a good solution. The google calendar works pretty well, especially on Android, and can be used with any device or service (e.g. zapier), so the main "back-end" can probably live on Google. At least for now.

Syncing is now set up with `vdirsyncer`. This is a manual process at the moment, though.

### Email - mutt, gmail, outlook -> `mutt`

Gmail is set up with an app password, and the Dracula theme is enabled. Unfortunately, it still takes a while for `mutt` to connect to the IMAP folder and load everything, and this would be great to improve on. Maybe create a local copy of the inbox? Also, Office365 doens't work currently, but might be possible. In any case, see [Jonathan's setup](https://jonathanh.co.uk/blog/mutt-setup.html) for inspiration.

[Mail retrieval](https://wiki.archlinux.org/index.php/Category:Mail_retrieval_agents) is done using `isync`. This also synchronizes changes done in `mutt`. Note that email deleted (and purged) from `mutt` is still visible in the Gmail "All Mail" folder (this behavior can be changed in Gmail settings). Currently `isync` uses `gopass` for the password, if this doesn't work with the automatic sync timer systemd unit, just create a plain text file with the gmail app password.

### Work chat and calls - `teams`

So I need to use teams for work. Tough life. For this, just run the official teams app on demand. People chat way too much anyway, and notifications come to the phone. Disable auto-starting (it probably won't work anyway) and stay running when closing. The "tray" is not enabled for Teams anyway.

Teams needs XWayland, and fail silently if GDK_BACKEND is set to wayland, so don't set that. Also, the internal microphone on at least ThinkPad T480s produces a lot of static if mic boost is on, so make sure to disable that. There are some docs on how to do this in the Arch wiki, but you can set it via `alsamixer` as well. (Not sure how persistent these changes are, though.)

In order to do screen sharing in Wayland, special care needs to be taken.

### Knackeriet chat - `slack`

Slack is usable by phone, and that is probably good enough. When in need, there is a slack CLI that can be used.

### Notes - keep -> `git`

Notes are now in Google Keep = no good. They should be moved to a private git repository. The main issue here is that notes need to be easily editable from the phone. This can perhaps happen via forestry.io, but it might be nice to create a custom solution for this.

## User stories

### Copy and paste - wlclipboard

- vim registers?

### Printing documents - `cups`

[Printing](https://wiki.archlinux.org/index.php/CUPS) needs the `cups` package. In order to enable printing, a queue needs to be added and enabled. These were the steps taken to install the printer at the Knackeriet office:

```bash
# get printers
lpinfo -v
# the hostname for the printer is "Bellman"
# add the queue, noting that AirPrint is enabled, so model can be "everywhere"
lpadmin -p knackeriet-bellman -E -v 'ipp://Bellman/ipp/print' -m everywhere
# set as default
lpoptions -d knackeriet-bellman
# acivate and set to accept jobs
cupsenable knackeriet-bellman
cupsaccept knackeriet-bellman
```

Note that this particular printer driver needs Ghostscript, so the `ghostscript` package needs to be installed. (This message/error was visible in the local CUPS web admin.)

Now it's possible to print to this default destination.

### Listening to music - spotify

### Code in the dark - brightnessctl

### Connect to the internet - networkd and owe

### Search the web - custom script

### Use external monitor - sway

## Development

Development of documentation and configuration should follow sane development practices as much as possible. Try to commit early and often, use feature branches where applicable, and conventional commits. Try to commit one "feature" or "bug fix" at a time. All config files that matter (that have been edited) should be included in this repo.

