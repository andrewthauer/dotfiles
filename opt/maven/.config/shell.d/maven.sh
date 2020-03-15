#
# Initialize maven environment
#

# Return if requirements not found
if ! command_exists "mvn"; then
  return 1
fi

#
# XDG specification
#

# Set the maven home
export M2_HOME="${XDG_DATA_HOME}/sdk/maven/current"

# Override the config/cache location
alias mvn='mvn -gs "$XDG_CONFIG_HOME/maven/settings.xml"'
