#
# Basic Java environment
#

# Set the JAVA_HOME
if [[ -d "${XDG_DATA_HOME}/sdk/java/current" ]]; then
  export JAVA_HOME="${XDG_DATA_HOME}/sdk/java/current"
  export JDK_HOME="${JDK_HOME:-$JAVA_HOME}"

# Warn that JAVA_HOME is not set
elif [[ -z "${JAVA_HOME}" ]]; then
  echo "\e[93mJAVA_HOME is not set"
fi

#
# XDG spec overrides
#

# Override the config/cache location
alias mvn="mvn -gs "${XDG_CONFIG_HOME}/maven/settings.xml""

# XDG specification for gradle
export GRADLE_USER_HOME="${XDG_DATA_HOME}/gradle"
