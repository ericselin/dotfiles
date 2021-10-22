# Add selected file or directery to the dotfiles repo

GIT_OPTS="--git-dir=$HOME/.dot.git/ --work-tree=$HOME"

function dotadd() {
  # unstaged changes
  local unstaged=$(dot diff --name-only)
  # get untracked files
  local untracked=$(dot ls-files --others --directory --exclude-standard --empty-directory :/)
  # get directory where the file lives
  # the preview command shows dir contents if its a dir, otherwise file contents with bat
  local path=$(printf "$unstaged\n\n$untracked" | fzf --preview="[ -d {} ] && ls -la {} || ([ -z {} ] && echo 'Unstaged below, untracked above' || (! git $GIT_OPTS diff --exit-code --color -- {} || bat --color=always {}))")

  # if selected was a directory, get file names from there
  if [ $path ] && [ -d $path ]; then
    # get the path of the file
    path=$(dot ls-files --others --exclude-standard $path | fzf --preview='bat {}')
  fi

  # exit if nothing selected
  if [ -z $path ]; then
    echo 'Nothing selected, nothing added.'
    return
  fi

  # add it!
  echo "Adding $path"
  dot add $path
}
