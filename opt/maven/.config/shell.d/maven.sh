#
# Initialize maven environment
#

# Return if requirements not found
if ! command_exists "mvn"; then
  return 1
fi

#
# Aliases
#

# Override the config/cache location
alias mvn="mvn -gs "$XDG_CONFIG_HOME/maven/settings.xml""
