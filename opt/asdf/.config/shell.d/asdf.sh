#
# Initialze asdf environment
#
# - https://github.com/asdf-vm/asdf
#

# XDG Specification
export ASDF_DATA_DIR="${XDG_DATA_HOME}/asdf"
export ASDF_CONFIG_FILE="${XDG_CONFIG_HOME}/asdf/asdfrc"
export ASDF_DEFAULT_TOOL_VERSIONS_FILENAME="${XDG_CONFIG_HOME}/asdf/tool-versions"

# Use custom asdf location
if [[ -n "${ASDF_DIR}" && -d "${ASDF_DIR}" ]]; then
  export ASDF_DIR

# Use git cloned asdf
elif [[ -f "${XDG_DATA_HOME}/asdf/bin/asdf.sh" ]]; then
  export ASDF_DIR="${XDG_DATA_HOME}/asdf"

# Use brew installed asdf
elif [[ -d "${BREW_PREFIX}/opt/asdf" ]]; then
  export ASDF_DIR="${BREW_PREFIX}/opt/asdf"

# Return if requirements not found
else
  return 1
fi

# Initialize asdf
source "${ASDF_DIR}/asdf.sh"

# Setup completions
if [[ -n "${BASH_VERSION}" ]]; then
  if [[ -f "${ASDF_DIR}/completions/asdf.bash" ]]; then
    source "${ASDF_DIR}/completions/asdf.bash"
  elif [[ -f "${BREW_PREFIX}/etc/bash_completion.d/asdf.bash" ]]; then
    source "${BREW_PREFIX}/etc/bash_completion.d/asdf.bash"
  fi
fi

#
# Aliases & helpers
#

alias asdfc='asdf current'
