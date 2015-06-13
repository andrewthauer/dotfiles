# !/bin/sh

tab-title() {
  title = $1
  echo -ne "\e]1;${title}\a"
}

is_share_mounted() {
  mount_point=$1

  if [ -z "$mount_point" ]; then
    echo "Argument Missing - Mount Point"
    return
  fi

  if [ -d "$mount_point" ]; then
    return 0
  else
    return 1
  fi
}

unmount_share() {
  mount_point=$1

  if is_share_mounted; then
    echo "Unmount -> ${mount_point}"
    diskutil unmount $mount_point
    # rm -r $mount_point
  fi
}

mount_share() {
  share_path=$1
  mount_point=$1

  if ! is_share_mounted; then
    echo "Mount -> ${share_path} on ${mount_point}"
    mkdir $mount_point
    mount -t smbfs $share_path $mount_point
  else
    echo "Already mounted -> ${mount_point}"
  fi
}
