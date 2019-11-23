#
# Initialize scala environment
#

# Use asdf if installed
if [[ -d "${XDG_DATA_HOME}/asdf/plugins/sbt" ]]; then
  echo "using asdf" >/dev/null

# Load sbt with sdkman candidate
elif [[ -d "${XDG_DATA_HOME}/sdkman/candidates/sbt" ]]; then
  require_once "sdkman"
  require_once "java"
  export SBT_HOME="${SDKMAN_DIR}/candidates/sbt/current"
  prepend_path "${SBT_HOME}/bin"
  unset SBT_HOME

# Return if requirements not found
elif ! command_exists "sbt"; then
  return 1
fi
