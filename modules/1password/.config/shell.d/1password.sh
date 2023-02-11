#
# Initialize 1password cli environment
#

if ! command_exists "op"; then
  return 1
fi

# Initial plugins
if [ -f "${XDG_CONFIG_HOME}/op/plugins.sh" ]; then
  # shellcheck source=./plugins.sh disable=SC1091
  source "${XDG_CONFIG_HOME}/op/plugins.sh"
fi

# Setup ssh agent
if [ -L "${XDG_CONFIG_HOME}/1password/agent.sock" ]; then
  export SSH_AUTH_SOCK="${XDG_CONFIG_HOME}/1password/agent.sock"
fi

# Aliases
alias opr="op run --"
