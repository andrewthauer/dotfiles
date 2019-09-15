#
# Redis aliases
#
# - https://redis.io/topics/rediscli
#

if command_exists "redis-cli"; then
  return
fi

alias r="redis-cli"
alias rkeys="redis-cli KEYS '*'"
alias rscana="redis-cli --scan --pattern '*'"
alias rflusha="redis-cli FLUSHALL"
alias rflushdb="redis-cli FLUSHDB"
