#
# fasd
# - https://github.com/clvv/fasd
#

# Skip if fasd is not installed
if [ -x "$(command -v fasd)" ]; then
  eval "$(fasd --init auto)"
fi
