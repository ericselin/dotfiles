#
# ~/.bashrc
#
# If not running interactively, don't do anything
[[ $- != *i* ]] && return

#
# ALIASES
#

alias ls='ls --color=auto'

# Set alias for managing the dotfiles git repo as per
# https://www.atlassian.com/git/tutorials/dotfiles
alias dot='git --git-dir=$HOME/.dot.git/ --work-tree=$HOME'

# Install packages with yay and fzf
alias yays='yay -Slq | fzf --multi --preview "yay -Si {1}" | xargs -ro yay -S'
# Remove packages with yay and fzf
alias yayr='yay -Qq | fzf --multi --preview "yay -Qi {1}" | xargs -ro yay -Rns'

alias l='ls -l'
alias ll='ls -la'

#
# PROMPT
#

BLUE='\e[34m'
GREEN='\e[32m'
RED='\e[31m'
BOLD='\e[1m'
RESET='\e[0m'

gitinfo() {
  if git rev-parse --git-dir > /dev/null 2>&1; then
    if [[ `git status --porcelain` ]]
    then
      STYLE='\e[1;31m'
    else
      STYLE='\e[1;32m'
    fi
    printf "$STYLE %s$RESET" $(git branch --show-current)
  fi
}

PS1="$BLUE\u@\h$RESET \w\$(gitinfo)\n\$ "

#
# AUTOCOMPLETIONS
#

source ~/.git-completion.bash

source /usr/share/fzf/completion.bash
source /usr/share/fzf/key-bindings.bash

#
# SETTINGS
#

# Add utilities to the path
export PATH="$HOME/utilities:$PATH"

# Launch Firefox with wayland
export MOZ_ENABLE_WAYLAND=1

# bemenu config (colors)
export BEMENU_OPTS="--tb '#81a1c1'\
 --tf '#2e3440'\
 --fb '#3b4252'\
 --ff '#d8dee9'\
 --nb '#3b4252'\
 --nf '#d8dee9'\
 --hb '#81a1c1'\
 --hf '#2e3440'\
 --sb '#81a1c1'\
 --sf '#2e3440'\
 --scb '#434c5e'\
 --scf '#4c566a'\
 --fn monospace 12"

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
