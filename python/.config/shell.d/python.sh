#
# Initialize python environment
#
# = https://github.com/pyenv/pyenv
#

# Use asdf if installed
if [[ -d "${XDG_DATA_HOME}/asdf/plugins/python" ]]; then
  echo "using asdf" >/dev/null

# Load package manager installed pyenv into shell session
elif command_exists "pyenv" || [[ -s "${XDG_DATA_HOME}/pyenv/bin/pyenv" ]]; then
  source_shell_lib "pyenv"

# Return if requirements not found
elif ! command_exists "python"; then
  unset -f _pyenv_init
  return 1
fi

#
# XDG specifications
#

export PYTHONSTARTUP="${XDG_CONFIG_HOME}/python/pythonrc.py"
export PYLINTHOME="${XDG_CACHE_HOME}/pylint"
