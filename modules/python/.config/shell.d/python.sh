#
# Initialize python environment
#
# = https://github.com/pyenv/pyenv
#

#
# XDG specifications
#

# NOTE: This is not required in python v3.13 to override the
#       the ~/.python-history location
export PYTHONSTARTUP="${XDG_CONFIG_HOME}/python/pythonrc.py"

# Pyhon lint
# export PYLINTHOME="${XDG_CACHE_HOME}/pylint"

#
# Aliases
#

alias pip-req='pip install -r requirements.txt'
