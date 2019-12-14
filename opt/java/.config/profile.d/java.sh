#
# Basic Java environment
#

# Set the JAVA_HOME
if [[ -d "${XDG_DATA_HOME}/sdk/java/current" ]]; then
  export JAVA_HOME="${XDG_DATA_HOME}/sdk/java/current"
  export JDK_HOME="${JDK_HOME:-$JAVA_HOME}"
fi
