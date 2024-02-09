# Add selected file or directery to the dotfiles repo

function dotadd() {
  local GIT_OPTS="--git-dir=$HOME/.dot.git/ --work-tree=$HOME"
  # unstaged changes
  local unstaged=$(git $GIT_OPTS diff --name-only)
  # get untracked files
  local untracked=$(git $GIT_OPTS ls-files --others --directory --exclude-standard --empty-directory :/)
  # get directory where the file lives
  # the preview command shows dir contents if its a dir, otherwise file contents with bat
  local path=$(printf "$unstaged\n\n$untracked" | \
    fzf --multi --preview="[ -d {} ] && ls -la {} \
      || ([ -z {} ] && echo 'Unstaged below, untracked above' \
      || ( \
        ! git $GIT_OPTS diff --exit-code --color -- {} \
        || bat --color=always {}) \
      )"
    )

  # if selected was a directory, get file names from there
  if [ "$path" ] && [ -d "$path" ]; then
    # get the path of the file
    # preview can be bat, because modified files are never listed as dirs
    path=$(git $GIT_OPTS ls-files --others --exclude-standard $path \
      | fzf --multi --preview='bat {}')
  fi

  # exit if nothing selected
  if [ -z "$path" ]; then
    echo 'Nothing selected, nothing added.'
    return
  fi

  # add it!
  echo "Adding $path"
  git $GIT_OPTS add $path
}
