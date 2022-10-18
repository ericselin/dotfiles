#
# ~/.bashrc
#

# Readline vi mode
# Move this to inputrc to use elsewhere?
# Try out https://bbs.archlinux.org/viewtopic.php?id=5573
set -o vi
bind -m vi-command '"h": backward-char'
bind -m vi-command '"s": forward-char'

export EDITOR=nvim

#
# ALIASES
#

alias ls='ls --color=auto'

# easier agenda
alias k='khal list'

# todo.txt
alias t='todo.sh'
export TODOTXT_DEFAULT_ACTION='next'
export TODOTXT_PRESERVE_LINE_NUMBERS='1'

# Set alias for managing the dotfiles git repo as per
# https://www.atlassian.com/git/tutorials/dotfiles
alias dot='git --git-dir=$HOME/.dot.git/ --work-tree=$HOME'
# Source dotfiles adding function `dotadd`
source ~/scripts/dotfiles-add.sh

# Install packages with yay and fzf
alias yays='yay -Slq | fzf --multi --preview "yay -Si {1}" | xargs -ro yay -S'
# Remove packages with yay and fzf
alias yayr='yay -Qqe | fzf --multi --preview "yay -Qi {1}" | xargs -ro yay -Rns'

alias l='ls -l'
alias ll='ls -la'

# sync email before opening mutt
alias mutts='mbsync --pull --new mailfence && mutt'

# use fd in fzf
export FZF_DEFAULT_COMMAND='fd --type f --hidden --exclude .git'
export FZF_CTRL_T_COMMAND="$FZF_DEFAULT_COMMAND"
export FZF_ALT_C_COMMAND='fd --type d --hidden --exclude .git'

#
# PROMPT
#

PROMPT_COMMAND=__prompt_command

__prompt_command() {
  # grab previous exit code here before it's overridden
  local exit="$?"

  # colors
  local blue='\e[34m'
  local green='\e[32m'
  local red='\e[31m'
  local bold='\e[1m'
  local magenta='\e[35m'
  local reset='\e[0m'

  # clear prompt
  PS1=''

  # if exit code > 0, add that on its own line in red
  [ $exit -gt 0 ] && PS1="$red$bold$exit$reset\n"

  # add default user@host and working dir
  PS1="$PS1$blue\u@\h$reset \w"

  # if we're in a git folder, get the branch name
  if git rev-parse --git-dir > /dev/null 2>&1; then
    # set style based on git status
    if [[ `git status --porcelain` ]]
    then
      local style="$red$bold"
    else
      local style="$green$bold"
    fi
    # add branch name
    PS1="$PS1 $style$(git branch --show-current)$reset"
  fi

  # final line with prompt char $
  PS1="$PS1\n\$ "
}


#
# AUTOCOMPLETIONS
#

__source_completion() {
  local file="$1"
  if [ -f "$file" ]; then
    source "$file"
  fi
}
__source_completion /usr/share/git/completion/git-completion.bash
__source_completion /usr/share/fzf/completion.bash
__source_completion /usr/share/fzf/key-bindings.bash
# freebsd bash-completion
[[ $PS1 && -f /usr/local/share/bash-completion/bash_completion.sh ]] && \
	source /usr/local/share/bash-completion/bash_completion.sh
# freebsd paths for the above
__source_completion /usr/local/share/examples/fzf/shell/completion.bash
__source_completion /usr/local/share/examples/fzf/shell/key-bindings.bash

# Add completion for dot
__git_complete dot __git_main

#
# SETTINGS
#

# Add utilities to the path
export PATH="$HOME/utilities:$PATH"

# Add go bin to path
export PATH="$HOME/go/bin:$PATH"

# Add deno installs to the path
export PATH="$HOME/.deno/bin:$PATH"

# wayland runtime dir
export XDG_RUNTIME_DIR=/var/run/user/`id -u`

# GPG SSH settings
if [ -z "$SSH_AUTH_SOCK" ];
then
  export SSH_AUTH_SOCK=$(gpgconf --list-dirs agent-ssh-socket)
  gpgconf --launch gpg-agent
fi

# Launch Firefox with wayland
export MOZ_ENABLE_WAYLAND=1

#
# COLORS
#

if [ "$TERM" = "linux" ]; then
    echo -en "\e]P02e3440" #black
    echo -en "\e]P1bf616a" #red
    echo -en "\e]P2a3be8c" #green
    echo -en "\e]P3ebcb8b" #yellow
    echo -en "\e]P481a1c1" #blue
    echo -en "\e]P5b38ead" #magenta
    echo -en "\e]P688c0d0" #cyan
    echo -en "\e]P7e5e9f0" #white
    # high intensity of the colors above
    echo -en "\e]P84c566a"
    echo -en "\e]P9bf616a"
    echo -en "\e]PAa3be8c"
    echo -en "\e]PBebcb8b"
    echo -en "\e]PC81a1c1"
    echo -en "\e]PDb48ead"
    echo -en "\e]PE8fbcbb"
    echo -en "\e]PFeceff4"
    clear #for background artifacting
fi

# GTK nord theme
gsettings set org.gnome.desktop.interface gtk-theme "Nordic"
gsettings set org.gnome.desktop.wm.preferences theme "Nordic"

#
# STARTUP
#

# auto-start sway on tty1
if [ -z $DISPLAY ] && [ "$(tty)" = "/dev/tty1" ]; then
    exec sway
fi
