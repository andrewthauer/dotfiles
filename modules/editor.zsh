# Opens files via the $EDITOR
edit () {
  if [[ $# = 0 ]] then
    $EDITOR
  else
    [[ $1 = /* ]] && F="$1" || F="$PWD/${1#./}"
    $EDITOR "$F"
  fi
}
