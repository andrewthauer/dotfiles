#
# Initialize java environment
#

# Use asdf if installed
if [[ -d "${XDG_DATA_HOME}/asdf/plugins/java" ]]; then
  export JAVA_HOME="${JAVA_HOME:-$(asdf where java)}"
  export JDK_HOME="${JDK_HOME:-$JAVA_HOME}"

# Return if requirements not found
elif ! command_exists "java"; then
  return 1
fi
