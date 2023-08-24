# Dotfiles

Well hello, you! Or rather, hello me in the future!

This is a repo of dotfiles, scripts and instructions for setting up a new
system. It is a bare repo and should be synced to the home folder according to
the [instructions here](https://www.atlassian.com/git/tutorials/dotfiles).

I'm trying to say a little bit about *why* certain things are the way they are,
or a particular tool has been chosen.

## Installation

```
curl -L https://git.io/JYeUL | /bin/bash
scripts/restore-system.sh
```

The short link above links to `scripts/restore-system.sh`. It will install
everything and clone this repo as a bare repo, backing up any existing files in
the process.

## Environment

These are the things that are needed in order to run things - the infrastructure
as at was. Things not listed here are considered part of the system or linked to
specific user stories.

- OS: `NixOS`

    Declarative configuration, and declarative package management.

- Window manager: `sway`

    Tiling, which is what you want.

- Status bar: `waybar`

    Minimalistic enough, and pretty well configurable.

- Terminal: `alacritty`

    Fast according to benchmarks. Has vim mode - not that I use it.

- Editor: `helix`

    Helix is a fast (modern?) editor with batteries included. Not as extensible
    as `vim`, so e.g. no `emmet` support, but I'll live.

- Launcher and menu: `fzmenu` (custom)

    Everything is possible via the scripts in `scripts/fzmenu`. Looks neat!

- Notifications: `mako`

    Mako "just works". It is very simple, but that's how I like it.

- Colors and font: `nord` and `Source Code Pro`

    Nord is dark and nice. Adobe's Source Code Pro is used, because Fira Code
    doesn't work in alacritty.

- Personal cloud: `NextCloud`

    Has it all, and is pretty much industry standard.

### Special notes on keyboard layout: `dvorak`

Dvorak is pretty great. It has made my coding much more productive, because
common keys like `/` and `[` are much more accessible than with a Finnish or
Swedish keyboard. Also, it's much easier on the hands, I think. The problem is
that some things don't work as well, since much of computing has been created
around the QWERTY layout. Here are some thoughts for remedying those.

#### International characters

One might of course switch keyboard layouts completely (to a international
QWERTY version) when writing with international characters. But this is not
nice. I'd rather have Dvorak with just the characters I need. The best solution
is to have `ö` and the likes under `a`, `o` and `e` with an AltGr modifier.

The US dvorak layouts have been extended by including the original layout and
making some changes. This is exactly what has been done in the "layout" named
"scandi-dvorak" in `.xkb/symbols`. It is applied with
`scripts/set-scandi-dvorak.sh`.

For reference, see:
- https://www.linux.com/news/extending-x-keyboard-map-xkb/
- https://www.x.org/wiki/XKB/

### Navigation (e.g. in `vim`)

Navigating in e.g. `vim` and `less` with a Dvorak layout is not very nice,
since the navigation keys are not on the home row. In order to achieve proper
navigation, just remap navigation to the home row keys. This of course means
that we have to remap the now shadowed "original" key commands. Here are some
thoughts on how to do this.

The home row of the right hand is H-T-N-S on Dvorak. Since we don't have the `:`
on the home row, we can map these keys as navigation. So essentially switching
`vim` navigation one key to the right.

- `h`: Move left (`j` on QWERTY)
- `t`: Move down (`k` on QWERTY)
- `n`: Move up   (`l` on QWERTY)
- `s`: Move rigt (`:` on QWERTY)

These keys now have to be remapped. E.g. `vim` has the "next occurence" for
search under `n`. This can be remapped as `l`, as in "look for more".

`less` is remapped by creating a less key file and running `lesskey`.

## Jobs to be done

### Logging into places (i.e. pw mgmt): `gopass`

This password manager is pretty cool, based on GPG-encrypted files and
compatible with [pass](https://www.passwordstore.org/).

There is a script for `fzmenu` that searches and copies passwords. `gopass` uses
`gpg`, and key passphrases are used via `gpg-agent`. Passphrases are entered
via a `pinentry` program, more specifically `pinentry-gnome3`. See optional
dependencies for `pinentry` for the proper dependencies for that `pinentry`
backend.

### Safeguard against data loss

Everything should live in the (personal) "cloud". At any point, the loss or
destruction of a device should be possible and deemed safe. (See also encryption
below.) All servers need to have cloud-provider-native backups, as well as
physical backups in my control.

### Safeguard against data theft

Encryption of the whole disk is just best for everything. No need to encrypt the
boot partition, though.

In order to protect passwords and certificates (mainly used for authentication),
hardware keys are used. Follow
[drduh's YubiKey Guide](https://github.com/drduh/YubiKey-Guide). A backup key
should exist.

### Source control: `git` and `gh-cli`

Git is pretty self explanatory and always required.

### Time boxing: `scripts/pomodoro.sh`

Time boxing is pretty powerful for time management.

- Start pomodoro with the `Mod-p` keyboard shortcut
- Notify user of pomodoro completion with `notify-send`
- Stop pomodoro with the `Mod-Shift-P` keyboard shortcut

### Manage my time: `khal`

Calendaring should be possible through the terminal. For this, `khal` with
syncing to the personal "cloud" is used. Syncing is now set up with
`vdirsyncer`. This is a manual process at the moment, though.

### Communicate with others: `mutt`

Email is synced locally via `mbsync`, so any mail client can be used. Mutt is
great in the same way as vim, so might need to check out alternatives, such
as `sup`.

### Notes: `Google Keep` -> `git`

Notes are now in Google Keep = no good. They should be moved to a private git
repository.

### Printing documents: `cups`

[Printing](https://wiki.archlinux.org/index.php/CUPS) needs the `cups` package.
In order to enable printing, a queue needs to be added and enabled. These were
the steps taken to install the printer at the Knackeriet office:

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

Note that it can be hard to get mDNS to work, which is why I actually installed
the printer with its IP address.

## Development

Development of documentation and configuration should follow sane development
practices as much as possible. Try to commit early and often, use feature
branches where applicable, and conventional commits. Try to commit one "feature"
or "bug fix" at a time. All config files that matter (that have been edited)
should be included in this repo.

