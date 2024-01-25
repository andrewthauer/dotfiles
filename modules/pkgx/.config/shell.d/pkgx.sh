#
# Initialize pkgx environment
#
# - https://pkgx.sh/
#

# Return if requirements not found
if ! command_exists "pkgx"; then
  return 1
fi

# Xdg configuration
export PKGX_DIR="${XDG_DATA_HOME}/pkgx"

# docs.pkgx.sh/shellcode
eval "$(pkgx --shellcode)"
