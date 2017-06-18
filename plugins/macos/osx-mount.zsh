#!/usr/bin/env zsh

function get_mount_volume () {
  share=$1
  mount_dir=${2:-/Volumes}
  echo "${mount_dir}/${share:t}"
}

function is_share_mounted () {
  share=$1
  mount_dir=${2:-/Volumes}
  mnt_volume=$(get_mount_volume ${share} ${mount_dir})
  if [ -d "$mnt_volume" ]; then
    return 0
  else
    return 1
  fi
}

function mount_share () {
  share=$1
  mount_dir=${2:-/Volumes}
  mnt_volume=$(get_mount_volume ${share} ${mount_dir})
  if ! $(is_share_mounted ${mnt_volume} ${mount_dir}); then
    echo "Mount -> ${share} on ${mnt_volume}"
    mkdir ${mnt_volume}
    mount -t smbfs ${share} ${mnt_volume}
  else
    echo "Already mounted -> ${mnt_volume}"
  fi
}

function unmount_share () {
  share=$1
  mount_dir=${2:-/Volumes}
  mnt_volume=$(get_mount_volume ${share} ${mount_dir})
  if $(is_share_mounted ${mnt_volume} ${mount_dir}); then
    echo "Unmount -> ${mnt_volume}"
    diskutil unmount ${mnt_volume}
    # rm -r $mnt_volume
  fi
}
