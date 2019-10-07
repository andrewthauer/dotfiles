#
# Initialize maven environment
#

require_once "sdkman"

# Load maven with sdkman candidate
if [[ -d "${SDKMAN_DIR}/candidates/maven" ]]; then
  require_once "java"
  MAVEN_HOME="${SDKMAN_DIR}/candidates/maven/current"
  export PATH="${MAVEN_HOME}/bin:${PATH}"
  unset MAVEN_HOME

# Return if requirements not found
elif ! command_exists "mvn"; then
  return 1
fi

#
# XDG specifications
#

# mvn -gs "$XDG_CONFIG_HOME"/maven/settings.xml
