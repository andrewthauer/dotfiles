#
# Initialize 1password cli environment
#

if ! command_exists "op"; then
  return 1
fi

# Initial plugins
if [ -f "${XDG_CONFIG_HOME}/op/plugins.sh" ]; then
  # shellcheck source=./plugins.sh disable=SC1091
  source_file "${XDG_CONFIG_HOME}/op/plugins.sh"
fi

# Agent configuration with SSH_AUTH_SOCK
export SSH_AUTH_SOCK="$HOME/Library/Group\ Containers/2BUA8C4S2C.com.1password/t/agent.sock"
