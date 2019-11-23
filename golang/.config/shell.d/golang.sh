#
# Initialize go environment
#
# - https://golang.org/
# - https://github.com/syndbg/goenv
#

# Use asdf if installed
if [[ -d "${XDG_DATA_HOME}/asdf/plugins/golang" ]]; then
  echo "using asdf" >/dev/null

# Load package manager installed goenv into shell session
elif command_exists "goenv" || [[ -s "${XDG_DATA_HOME}/goenv/bin/goenv" ]]; then
  source_shell_lib "goenv"

# Return if requirements not found
elif ! command_exists "go"; then
  return 1
fi
