# !/bin/sh

realpath() {
  echo $(cd $(dirname $1); pwd)/$(basename $1)
}

set_tab_title() {
  title = $1
  echo -ne "\e]1;${title}\a"
}

function_exists() {
  FUNCTION_NAME=$1
  [ -z "$FUNCTION_NAME" ] && return 1
  declare -F "$FUNCTION_NAME" > /dev/null 2>&1
  return $?
}

find_latest_file() {
  dir=$1
  pattern=$2

  [ -z "${dir}" ] && echo "Directory not provided" && return 1
  [ ! -d "${dir}" ] && echo "Directory does not exist" && return 1
  [ -z "${pattern}" ] && echo "Pattern not provided" && return 1

  # glob directory -> filter by pattern -> sort by date -> one result
  echo $(ls ${dir}/**/*(e:'[[ $REPLY =~ ${pattern} ]]':.om[1]))
}

get_mount_volume() {
  share=$1
  echo "/Volumes/${share:t}"
}

is_share_mounted() {
  share=$1
  mnt_volume=$(get_mount_volume $share)
  if [ -d "$mnt_volume" ]; then
    return 0
  else
    return 1
  fi
}

mount_share() {
  share=$1
  mnt_volume=$(get_mount_volume $share)
  if ! $(is_share_mounted $mnt_volume); then
    echo "Mount -> ${share} on ${mnt_volume}"
    mkdir $mnt_volume
    mount -t smbfs $share $mnt_volume
  else
    echo "Already mounted -> ${mnt_volume}"
  fi
}

unmount_share() {
  share=$1
  mnt_volume=$(get_mount_volume $share)

  if $(is_share_mounted $mnt_volume); then
    echo "Unmount -> ${mnt_volume}"
    diskutil unmount $mnt_volume
    # rm -r $mnt_volume
  fi
}

fancy_echo() {
  local fmt="$1"; shift

  # shellcheck disable=SC2059
  printf "\n$fmt\n" "$@"
}

append_to_zshrc() {
  local text="$1" zshrc
  local skip_new_line="${2:-0}"

  if [ -w "$HOME/.zshrc.local" ]; then
    zshrc="$HOME/.zshrc.local"
  else
    zshrc="$HOME/.zshrc"
  fi

  if ! grep -Fqs "$text" "$zshrc"; then
    if [ "$skip_new_line" -eq 1 ]; then
      printf "%s\n" "$text" >> "$zshrc"
    else
      printf "\n%s\n" "$text" >> "$zshrc"
    fi
  fi
}

ensure_dir_var_or_default() {
  dir_var=$1
  default_dir=$2

  if [ -z "${dir_var}" ] && [ -e "${default_dir}" ]; then
    echo ${fg[yellow]}"Warning - '${dir_var}' not set. Defaulting -> '${default_dir}'"${reset_color}
    dir=${default_dir}
  elif [ ! -e "${default_dir}" ]; then
    echo ${fg[yellow]}"Warning - '${dir_var}' not set. Default Not Found -> '${default_dir}'"${reset_color}
    dir=""
  else
    echo ${dir_var}
    dir=${dir_var}
  fi

  echo $dir
}
