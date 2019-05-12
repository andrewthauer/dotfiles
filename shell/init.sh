#
# Initialize common shell tools
#

# fasd
if [[ -x "$(command -v fasd)" ]]; then
  eval "$(fasd --init auto)"
fi
