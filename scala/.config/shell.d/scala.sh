#
# Initialize scala environment
#

# Load scala with sdkman candidate
if [[ -d "${XDG_DATA_HOME}/sdkman/candidates/scala" ]]; then
  # source_shell_lib "sdkman"
  export SCALA_HOME="${SDKMAN_DIR}/candidates/scala/current"
  prepend_path "${SCALA_HOME}/bin"
  unset SCALA_HOME

# Return if requirements not found
elif ! command_exists "scala"; then
  return 1
fi
