#
# fasd
# - https://github.com/clvv/fasd
#

# Load fasd if installed
if [[ -x "$(command -v fasd)" ]]; then
  eval "$(fasd --init auto)"
fi
