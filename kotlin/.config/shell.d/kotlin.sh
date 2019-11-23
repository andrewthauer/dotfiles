#
# Initialize kotlin environment
#

# Use asdf if installed
if [[ -d "${XDG_DATA_HOME}/asdf/plugins/kotlin" ]]; then
  echo "using asdf" >/dev/null

# Load kotlin with sdkman candidate
elif [[ -d "${XDG_DATA_HOME}/sdkman/candidates/kotlin" ]]; then
  source_shell_lib "sdkman"
  export KOTLIN_HOME="${SDKMAN_DIR}/candidates/kotlin/current"
  prepend_path "${KOTLIN_HOME}/bin"

# Return if requirements not found
elif ! command_exists "kotlin"; then
  return 1
fi
