#
# Initialze asdf environment
#
# - https://github.com/asdf-vm/asdf
#

# XDG Specification
export ASDF_DATA_DIR="${ASDF_DATA_DIR:-$XDG_DATA_HOME}/asdf}"
export ASDF_CONFIG_FILE="${ASDF_CONFIG_FILE:-$XDG_CONFIG_HOME/asdf/asdfrc}"
export ASDF_DEFAULT_TOOL_VERSIONS_FILENAME="${ASDF_DEFAULT_TOOL_VERSIONS_FILENAME:-$XDG_CONFIG_HOME/asdf/tool-versions}"

# Fix for nodejs global install
# - https://github.com/asdf-vm/asdf-nodejs/issues/46
export ASDF_SKIP_RESHIM=1

# Use custom asdf location
if [[ -n "${ASDF_DIR}" && -d "${ASDF_DIR}" ]]; then
  export ASDF_DIR

# Use git cloned asdf
elif [[ -f "${XDG_DATA_HOME}/asdf/bin/asdf.sh" ]]; then
  export ASDF_DIR="${XDG_DATA_HOME}/asdf"

# Use brew installed asdf
elif [[ -d "${PROFILE_PREFIX}/opt/asdf" ]]; then
  export ASDF_DIR="${PROFILE_PREFIX}/opt/asdf/libexec"

# Use nix installed asdf
elif [[ -d "${HOME}/.nix-profile/share/asdf-vm" ]]; then
  export ASDF_DIR="${HOME}/.nix-profile/share/asdf-vm/lib"

# Return if requirements not found
else
  return 1
fi

# Initialize asdf
# shellcheck disable=SC1091
source "${ASDF_DIR}/asdf.sh"

# Setup completions
if [[ -n "${BASH_VERSION}" ]]; then
  if [[ -f "${ASDF_DIR}/completions/asdf.bash" ]]; then
    # shellcheck disable=SC1091
    source "${ASDF_DIR}/completions/asdf.bash"
  elif [[ -f "${PROFILE_PREFIX}/etc/bash_completion.d/asdf.bash" ]]; then
    # shellcheck disable=SC1091
    source "${PROFILE_PREFIX}/etc/bash_completion.d/asdf.bash"
  fi
elif [[ -n "${ZSH_VERSION}" ]]; then
  if [[ -f "${ASDF_DIR}/completions/_asdf" ]]; then
    # shellcheck disable=SC2128
    fpath=("$fpath" "${ASDF_DIR}/completions")
  fi
fi

#
# Aliases & helpers
#

alias asdfc='asdf current'
