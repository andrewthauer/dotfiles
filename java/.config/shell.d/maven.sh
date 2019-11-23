#
# Initialize maven environment
#

# Use asdf if installed
if [[ -d "${XDG_DATA_HOME}/asdf/plugins/maven" ]]; then
  echo "using asdf" >/dev/null

# Load maven with sdkman candidate
elif [[ -d "${XDG_DATA_HOME}/sdkman/candidates/maven" ]]; then
  source_shell_lib "sdkman"
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
