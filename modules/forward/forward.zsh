# start forward tunnel
forwardit() {
  if [ -z "$1" ]; then
    dir=$(basename "$PWD")
  else
    dir=$1
  fi
  url="${dir}.dev"
  prefix="${USER}-${dir}"
  echo -ne "\e]1;Forward: ${prefix}\a"
  forward $url $prefix
}
