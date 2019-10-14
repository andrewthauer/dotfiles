#
# Initialize scala environment
#

require_once "sdkman"

# Load scala with sdkman candidate
if [[ -d "${SDKMAN_DIR}/candidates/scala" ]]; then
  require_once "java"
  export SCALA_HOME="${SDKMAN_DIR}/candidates/scala/current"
  prepend_path "${SCALA_HOME}/bin"
  unset SCALA_HOME
fi

# Load sbt with sdkman candidate
if [[ -d "${SDKMAN_DIR}/candidates/sbt" ]]; then
  require_once "java"
  export SBT_HOME="${SDKMAN_DIR}/candidates/sbt/current"
  prepend_path "${SBT_HOME}/bin"
  unset SBT_HOME
fi
