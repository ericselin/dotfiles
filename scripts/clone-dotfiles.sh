#!/bin/bash
git clone --recurse-submodules --bare https://github.com/ericselin/dotfiles.git $HOME/.dot.git
function config {
   /usr/bin/git --git-dir=$HOME/.dot.git/ --work-tree=$HOME $@
}
config checkout
if [ $? = 0 ]; then
  echo "Checked out config.";
  else
    echo "Backing up pre-existing dot files.";
    mkdir -p .dotfiles-backup
    config checkout 2>&1 | egrep "\s+\." | awk {'print $1'} | xargs -I{} mv {} .dotfiles-backup/{}
fi;
config checkout
config config status.showUntrackedFiles no