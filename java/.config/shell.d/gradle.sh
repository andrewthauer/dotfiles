#
# Initialize gradle environment
#

# Use asdf if installed
if [[ -d "${XDG_DATA_HOME}/asdf/plugins/gradle" ]]; then
  echo "using asdf" >/dev/null

# Load gradle with sdkman candidate
elif [[ -d "${XDG_DATA_HOME}/sdkman/candidates/gradle" ]]; then
  source_shell_lib "sdkman"
  export GRADLE_HOME="${SDKMAN_DIR}/candidates/gradle/current"
  prepend_path "${GRADLE_HOME}/bin"

# Return if requirements not found
elif ! command_exists "gradle"; then
  return 1
fi

#
# XDG specifications
#

export GRADLE_USER_HOME="${XDG_DATA_HOME}/gradle"
