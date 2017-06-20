# OSX volumn mount plugin helpers

get_mount_volume() {
  local share=$1
  local mount_dir=${2:-/Volumes}
  echo "${mount_dir}/${share:t}"
}

is_share_mounted() {
  local share=$1
  local mount_dir=${2:-/Volumes}
  local mnt_volume=$(get_mount_volume ${share} ${mount_dir})

  if [ -d "$mnt_volume" ]; then
    return 0
  else
    return 1
  fi
}

mount_share() {
  local share=$1
  local mount_dir=${2:-/Volumes}
  local mnt_volume=$(get_mount_volume ${share} ${mount_dir})

  if ! $(is_share_mounted ${mnt_volume} ${mount_dir}); then
    echo "Mount -> ${share} on ${mnt_volume}"
    mkdir ${mnt_volume}
    mount -t smbfs ${share} ${mnt_volume}
  else
    echo "Already mounted -> ${mnt_volume}"
  fi
}

unmount_share() {
  local share=$1
  local mount_dir=${2:-/Volumes}
  local mnt_volume=$(get_mount_volume ${share} ${mount_dir})

  if $(is_share_mounted ${mnt_volume} ${mount_dir}); then
    echo "Unmount -> ${mnt_volume}"
    diskutil unmount ${mnt_volume}
    # rm -r $mnt_volume
  fi
}
