#
# Initialize java environment
#

# Use asdf if installed
if [[ -d "${XDG_DATA_HOME}/asdf/plugins/java" ]]; then
  export JAVA_HOME="${JAVA_HOME:-$(asdf where java)}"
  export JDK_HOME="${JDK_HOME:-$JAVA_HOME}"

# Load package manager installed jenv into shell session
elif command_exists "jenv" || [[ -s "${XDG_DATA_HOME}/jenv/bin/jenv" ]]; then
  source_shell_lib 'jenv'

# Load java with sdkman candidate
elif [[ -d "${XDG_DATA_HOME}/sdkman/candidates/java" ]]; then
  source_shell_lib "sdkman"

# Return if requirements not found
elif ! command_exists "java"; then
  return 1
fi
