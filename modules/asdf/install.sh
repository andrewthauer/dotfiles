#!/usr/bin/env bash
#
# Setup asdf version manager
#

# set -e

# Common variables
ASDF_VERSION=v0.4.3
ASDF_LATEST_CMD="$(dirname $0)/bin/asdf-latest"

# Plugins to use
# TODO: Read from file
declare -A ASDF_PLUGINS=(
  ["elm"]=""
  ["golang"]=""
  ["nodejs"]="8"
  ["python"]="2"
  ["python"]="3"
  ["ruby"]="2"
  ["rust"]="stable"
  ["terraform"]=""
)

# Install asdf (if required)
if [[ ! -d "${HOME}/.asdf" ]]; then
  echo "Installing asdf -- ${ASDF_VERISON}"
  git clone https://github.com/asdf-vm/asdf.git ~/.asdf --branch ${ASDF_VERSION}

  echo "Initializing asdf ..."
  source ${HOME}/.asdf/asdf.sh
fi

# Update asdf
echo "Updating asdf ..."
asdf update

# Post install hook for nodejs plugin
nodejs_install_hook() {
  # Import the Node.js release team's OpenPGP keys to main keyring:
  echo "Importing Node.js OpenPGP keys ..."
  bash ~/.asdf/plugins/nodejs/bin/import-release-team-keyring
}

# Post plugin install hook
plugin_install_hook() {
  plugin=$1
  if [[ "$(declare -Ff "${plugin}_install_hook")" ]]; then
    ${plugin}_install_hook
  fi
}

# Add plugins & install latest version
echo "Adding asdf plugins ..."
for plugin in "${!ASDF_PLUGINS[@]}"; do
  # Add plugin
  echo "Adding ${plugin} plugin"
  asdf plugin-add ${plugin}
  plugin_install_hook ${plugin}

  # Get latest desired plugin version
  filter="${ASDF_PLUGINS[$plugin]}"
  version=$(${ASDF_LATEST_CMD} "${plugin}" "${filter}")

  # Install plugih version
  echo "Installing ${plugin} version ${version}"
  asdf install ${plugin} ${version}

  # # Set plugin global version
  echo "Global ${plugin} version ${version}"
  asdf global ${plugin} ${version}
done

# List all current versions
asdf current
