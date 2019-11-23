#
# Initialize scala environment
#


# Use asdf if installed
if [[ -d "${XDG_DATA_HOME}/asdf/plugins/scala" ]]; then
  echo "using asdf" >/dev/null

# Load scala with sdkman candidate
elif [[ -d "${XDG_DATA_HOME}/sdkman/candidates/scala" ]]; then
  require_once "sdkman"
  require_once "java"
  export SCALA_HOME="${SDKMAN_DIR}/candidates/scala/current"
  prepend_path "${SCALA_HOME}/bin"
  unset SCALA_HOME

# Return if requirements not found
elif ! command_exists "scala"; then
  return 1
fi
