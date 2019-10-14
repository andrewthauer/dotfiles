#
# Initialize kotlin environment
#

require_once "sdkman"

# Load kotlin with sdkman candidate
if [[ -d "${SDKMAN_DIR}/candidates/kotlin" ]]; then
  require_once "java"
  export KOTLIN_HOME="${SDKMAN_DIR}/candidates/kotlin/current"
  export PATH="${KOTLIN_HOME}/bin:${PATH}"
fi
