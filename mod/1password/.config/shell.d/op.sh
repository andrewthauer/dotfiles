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

# Aliases
alias opr="op run --"

#
# helper functions
#

use-1password-ssh-agent() {
  if [ -L "${XDG_CONFIG_HOME}/1password/agent.sock" ]; then
    export SSH_AUTH_SOCK="${XDG_CONFIG_HOME}/1password/agent.sock"
  else
    echo "1password ssh agent not found"
    return 1
  fi
}

# Load 1Password environment variables
# alias ope='eval $(op-dotenv.ts "$HOME"/.config/.env --export)'
ope() {
  local env_file="${1:-${DOTFILES_ENV_FILE:-$HOME/.config/.env}}"
  # shellcheck disable=sc2046
  eval $(op-dotenv.ts "$env_file" --export)
}

