# Dotfiles

This is a repo of dotfiles, scripts and instructions for setting up a new system. It is a bare repo and should be synced to the home folder according to the [instructions here](https://www.atlassian.com/git/tutorials/dotfiles).

It is also an attempt at creating the perfect Linux configurtion. Perfect for me, of course.

This is all written mainly for myself, or more specifically a future version of myself (hi there, me!).

## Installation

```
curl -L https://git.io/JYeUL | /bin/bash
```

The short link above links to `scripts/clone-dotfiles.sh`. It will clone this repo as a bare repo, backing up any existing files in the process.

## Environment

These are the thins that are needed in order to run things - the infrastructure as at was. Things not listed here are considered part of the system or linked to specific user stories.

### Minimalistic Linux OS - `Arch Linux`

Arch Linux is pretty cool, check it out. It requires some setup, though. Things to still implement:

TODO status os: ANNOYING

- TODO os: bluetooth error on login
- TODO os: bluetooth headset audio
- TODO os: configure / research copy-paste between alacritty and e.g. firefox, and within alacritty same or different windows

### Window manager for Wayland - `sway`

`sway` is a tiling window manager, which is *really* what you want. Setup includes:

- **Screen locking** is done via `swayidle` and `swaylock`.
- **Status bar** in use is `i3status` and can be configured quite well.

TODO status sway: GOOD

- TODO swaybar: Add support for nicer looking emojis
- TODO sway: create `swaylock` dracula theme

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

TODO status gopass: DEGRADED

- TODO gopass: plan migration from keepass

### Back everything up (rule of three)

TODO status backup: CRITICAL

- TODO backup: plan backup next steps
- TODO backup: secure backups for e.g. gpg keys

### Disaster recovery

- TODO recovery: plan restoring backups W/F backup
- TODO recovery: create proper (indepodent) installer that installs with pacman and sets up everything
- TODO recovery: add oh-my-zsh as a submodule

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

Personal todos are now mainly in humla.app, save for todos in this file. Work todos are mainly issues in GitHub, with some additions in humla. There should pretty obviously be only one source of truth, accessible from all devices. A CLI would be extremely awesome for Linux environments (possibly Deno in order to make it OS-independent). This could be coupled with note taking, which would make it easy to turn a note into a todo.

TODO status todo: DEGRADED

- TODO todo: plan unified todos next steps

### Pomodoros - custom script `scripts/pomodoro.sh`

This script will create a file `~/pomodoro` with a ascii progress bar. This file can then be read by `i3status` to output the bar. The following features are implemented:

- Start pomodoro with the `Win-p` keyboard shortcut
- Stop pomodoro with the `Win-Shift-P` keyboard shortcut (intercepts the SIGINT and removes the file)
- Refresh i3status on update via the SIGUSR1 signal
- Notify user of pomodoro completion with `i3-nagbar`

TODO status pomodoro: ANNOYING

- TODO pomodoro: Make notification more like a message, and dismissable with keyboard

### Calendar - google -> `khal`

Calendaring should be possible through the terminal. For this, `khal` with syncing seems like a good solution. The google calendar works pretty well, especially on Android, and can be used with any device or service (e.g. zapier), so the main "back-end" can probably live on Google. At least for now.

TODO status calendar: ANNOYING

- TODO calendar: set up khal with local syncing

### Email - mutt, gmail, outlook -> `mutt`

Gmail is set up with an app password, and the Dracula theme is enabled. Unfortunately, it still takes a while for `mutt` to connect to the IMAP folder and load everything, and this would be great to improve on. Maybe create a local copy of the inbox? Also, Office365 doens't work currently, but might be possible. In any case, see [Jonathan's setup](https://jonathanh.co.uk/blog/mutt-setup.html) for inspiration.

[Mail retrieval](https://wiki.archlinux.org/index.php/Category:Mail_retrieval_agents) should probably be done using `isync`. Unclear how this works with Office365, though.

TODO status email: ANNOYING

- TODO email: set up local retrieval of gmail
- TODO email: set up local retrieval of office365
  this should probably be done using `davmail` as in [this example](https://movementarian.org/blog/posts/mutt-and-office365/)

### Work chat and calls - `teams`

So I need to use teams for work. Tough life. For this, just run the official teams app on demand. People chat way too much anyway, and notifications come to the phone. Disable auto-starting (it probably won't work anyway) and stay running when closing. The "tray" is not enabled for Teams anyway.

Teams needs XWayland, and fail silently if GDK_BACKEND is set to wayland, so don't set that. Also, the internal microphone on at least ThinkPad T480s produces a lot of static if mic boost is on, so make sure to disable that. There are some docs on how to do this in the Arch wiki, but you can set it via `alsamixer` as well. (Not sure how persistent these changes are, though.)

### Knackeriet chat - `slack`

Slack is usable by phone, and that is probably good enough. When in need, there is a slack CLI that can be used.

### Notes - keep -> `git`

Notes are now in Google Keep = no good. They should be moved to a private git repository. The main issue here is that notes need to be easily editable from the phone. This can perhaps happen via forestry.io, but it might be nice to create a custom solution for this.

TODO status notes: ANNOYING

- TODO notes: plan next steps

## User stories

### Copy and paste - wlclipboard

- vim registers?

### Printing documents - cups

### Listening to music - spotify

### Code in the dark - brightnessctl

### Connect to the internet - networkd and owe

### Search the web - custom script

### Use external monitor - sway

## Development

Development of documentation and configuration should follow sane development practices as much as possible. Try to commit early and often, use feature branches where applicable, and conventional commits. Try to commit one "feature" or "bug fix" at a time. All config files that matter (that have been edited) should be included in this repo.

