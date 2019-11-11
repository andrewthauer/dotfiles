#
# Initialize maven environment
#

require_once "sdkman"

# Load maven with sdkman candidate
if [[ -d "${SDKMAN_DIR}/candidates/maven" ]]; then
  require_once "java"
  export MAVEN_HOME="${SDKMAN_DIR}/candidates/maven/current"
  prepend_path "${MAVEN_HOME}/bin"

# Return if requirements not found
elif ! command_exists "mvn"; then
  return 1
fi

#
# Aliases
#

# Override the config/cache location
alias mvn="mvn -gs "$XDG_CONFIG_HOME/maven/settings.xml""
