#/usr/bin/env bash
#
# Generates & installs nativefier apps
#

set -e -o pipefail
sudo -v

target_dir="/opt"
arch="linux-x64"
icons_url="https://raw.githubusercontent.com/jiahaog/nativefier-icons/gh-pages/files"

check_nativefier() {
  if [[ ! -x (command -v nativefier) ]]; then
    echo "Installing nativefier ..."
    yarn global add nativefier
  fi
}

main() {
  name="$1"
  url="$2"
  extra_opts="${@:3}"
  icon_opt=""

  check_nativefier

  pushd "$HOME/Downloads" >/dev/null

  # Get icon
  curl "$icons_url/$name.png" > "$name.png"
  if ! grep -q 404 "$name.png"; then
    icon_opt="--icon '$name.png'"
  fi

  # Build app
  nativefier --name "'$name'" "$url" "$icon_opt" "$extra_opts"

  # Move app
  sudo rm -rf "$target_dir/$name"
  sudo mv "./$name-$arch" "$target_dir/$name"

  popd >/dev/null
}

main $@
