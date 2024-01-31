#
# Initialize node environment
#
# - https://github.com/nodenv/nodenv
#

#
# XDG specifications
#

# Node
export NODE_REPL_HISTORY="${XDG_DATA_HOME}/node_repl_history"

# Npm
export NPM_CONFIG_DEVDIR="${XDG_CACHE_HOME}/node-gyp"
export NPM_CONFIG_USERCONFIG="${XDG_CONFIG_HOME}/npm/config"
export NPM_CONFIG_CACHE="${XDG_CACHE_HOME}/npm"
# export NPM_CONFIG_TMP="${XDG_RUNTIME_DIR}/npm"
# export NODE_REPL_HISTORY="${XDG_DATA_HOME}/node_repl_history"

#
# Aliases
#

# npm list
alias npm-list='npm list --depth=0 2>/dev/null'
alias npm-list-g='npm list -g --depth=0 2>/dev/null'

# npm outdated
alias npm-outdated='npm outdated --depth 0 -q'
alias npm-outdated-g='npm outdated -g --depth 0 -q'
