# Add selected file or directery to the dotfiles repo

function dotadd() {
  # get directory where the file lives
  # the preview command shows dir contents if its a dir, otherwise file contents with bat
  path=$(dot ls-files --others --directory --exclude-standard --empty-directory :/ | fzf --preview='[ -d {} ] && ls -la {} || bat {}')

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
