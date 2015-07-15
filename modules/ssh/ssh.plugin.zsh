# -------------------------------------
# SSH helpers

# Create a composite ssh config file
merge_ssh_config() {
  src_configs=
  dest_config=

  # if [ -z "$src_configs" ]; then 'No source configs provided'; return; fi

  # Defaults
  [ -z "$dest_config" ] && src_configs=$ssh_configs
  [ -z "$dest_config" ] && dest_config="~/.ssh/config"

  # Truncate the file
  if [ -e "$HOME/.ssh/config" ]; then
    echo -n "Do you want to replace the existing '${dest_config}' file (yes or no)?"
    read reply
    if [[ $reply =~ ^[Yy]$ ]]; then
      cat /dev/null >! ~/.ssh/config
    fi
  fi

  # Append configs to the ~/.ssh/config
  for conf in "${ssh_configs[@]}"; do
    cat "$conf" >> ~/.ssh/config
    echo "" >> ~/.ssh/config
  done
}
