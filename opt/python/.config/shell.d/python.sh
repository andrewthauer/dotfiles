#
# Initialize python environment
#
# = https://github.com/pyenv/pyenv
#

# Return if requirements not found
if ! command_exists "python"; then
  return 1
fi

#
# XDG specifications
#

export PYTHONSTARTUP="${XDG_CONFIG_HOME}/python/pythonrc.py"
export PYLINTHOME="${XDG_CACHE_HOME}/pylint"

#
# Aliases
#

alias pipreq='pip install -r requirements.txt'
alias pe='pipenv'
