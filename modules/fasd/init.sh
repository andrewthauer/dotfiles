#
# Initialize fasd modules
#

# Initialize fasd (if installed)
if command_exists "fasd"; then
  eval "$(fasd --init auto)"
fi
