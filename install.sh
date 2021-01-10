#!/bin/sh

# real path of dotfiles directory
DOT_PATH=$HOME/dotfiles
CMD_NAME=`basename $0`

# link to $DOT_PATH/.* from $HOME/.*
for f in $(find . | sed 's@^\./@@'); do
  # ignore patterns
  case "$f" in
    "$CMD_NAME" | \.git* | _* | *.swp | *.md ) continue ;;
  esac

  [ -d "$f" ] && continue

  # make directory
  dir=$(dirname $f)
  [ -d "$HOME/$dir" ] || mkdir -p "$HOME/$dir"

  # test echo 
  #echo "$f" && continue

  # make links
  case "$f" in
    \.login_conf )
      # hard link
      ln -fv   "$DOT_PATH/$f" "$HOME"/"$f"
      ;;
    * )
      # symbolic link
      ln -snfv "$DOT_PATH/$f" "$HOME"/"$f"
      ;;
  esac
done

