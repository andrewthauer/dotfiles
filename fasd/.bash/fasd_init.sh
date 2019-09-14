#
# Initialize fasd
#
# - https://github.com/clvv/fasd
#

_init_fasd() {
  eval "$(fasd --init auto)"
  unset $0
}

# Initialize fasd (if installed)
if command_exists "fasd"; then
  _init_fasd
else
  unset _init_fasd
fi
