#
# Basic Java environment
#

SDKMAN_DIR="${SDKMAN_DIR:-$XDG_DATA_HOME/sdkman}"

# Basic java env
if [[ -d "${SDKMAN_DIR}/candidates/java/current" ]]; then
  export JAVA_HOME="${SDKMAN_DIR}/candidates/java/current"
  export JDK_HOME="${JAVA_HOME}"
else
  return 1
fi

#
# XDG spec overrides
#

# Override the config/cache location
alias mvn="mvn -gs "${XDG_CONFIG_HOME}/maven/settings.xml""

# XDG specification for gradle
export GRADLE_USER_HOME="${XDG_DATA_HOME}/gradle"
