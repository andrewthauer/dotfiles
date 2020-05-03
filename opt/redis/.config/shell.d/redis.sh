#
# Redis environment
#
# - https://redis.io/topics/rediscli
#

if ! command_exists "redis-cli"; then
  return 1
fi

# History file location
[[ ! -d "${XDG_DATA_HOME}/redis-cli" ]] && mkdir -p "${XDG_DATA_HOME}/redis-cli"
export REDISCLI_HISTFILE="${XDG_DATA_HOME}/redis-cli/history"

#
# Aliases
#

alias redis='redis-cli'
alias redis-keys='redis-cli KEYS "*"'
alias redis-scana='redis-cli --scan --pattern "*"'
alias redis-flusha='redis-cli FLUSHALL'
alias redis-flushdb='redis-cli FLUSHDB'
