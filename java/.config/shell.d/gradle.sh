#
# Initialize gradle environment
#

require_once "sdkman"

# Load gradle with sdkman candidate
if [[ -d "${SDKMAN_DIR}/candidates/gradle" ]]; then
  require_once "java"
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
