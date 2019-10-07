#
# Initialize scala environment
#

require_once "sdkman"

# Load scala with sdkman candidate
if [[ -d "${SDKMAN_DIR}/candidates/scala" ]]; then
  require_once "java"
  export SCALA_HOME="${SDKMAN_DIR}/candidates/scala/current"
  export PATH="${SCALA_HOME}/bin:${PATH}"
  unset SCALA_HOME
fi

# Load sbt with sdkman candidate
if [[ -d "${SDKMAN_DIR}/candidates/sbt" ]]; then
  require_once "java"
  export SBT_HOME="${SDKMAN_DIR}/candidates/sbt/current"
  export PATH="${SBT_HOME}/bin:${PATH}"
  unset SBT_HOME
fi
