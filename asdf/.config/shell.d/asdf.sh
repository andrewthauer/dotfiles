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
  echo "using custom asdf dir" >/dev/null

# Use git cloned asdf
elif [[ -f "${ASDF_DATA_DIR}/asdf.sh" ]]; then
  export ASDF_DIR="${ASDF_DATA_DIR}"

# Use default asdf location
elif [[ -d "${HOME}/.asdf" ]]; then
  export ASDF_DIR="${HOME}/.asdf"

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
if [[ -f "${ASDF_DIR}/completions/asdf.bash" ]]; then
  source "${ASDF_DIR}/completions/asdf.bash"
elif [[ -f "${BREW_PREFIX}/etc/bash_completion.d/asdf.bash" ]]; then
  source "${BREW_PREFIX}/etc/bash_completion.d/asdf.bash"
fi

#
# Aliases & helpers
#

alias asdfc="asdf current"
