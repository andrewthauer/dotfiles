#
# Redis environment
#
# - https://redis.io/topics/rediscli
#

if ! command_exists "redis-cli"; then
  return 1
fi

#
# Aliases
#

alias redis='redis-cli'
alias redis-keys='redis-cli KEYS "*"'
alias redis-scana='redis-cli --scan --pattern "*"'
alias redis-flusha='redis-cli FLUSHALL'
alias redis-flushdb='redis-cli FLUSHDB'
