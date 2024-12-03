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
# export PYTHON_HISTORY="${XDG_STATE_HOME}/python/history"
# export PYTHONUSERBASE="${XDG_DATA_HOME}/python"
# export PYTHONPYCACHEPREFIX="${XDG_CACHE_HOME}/python"

# Pyhon lint
# export PYLINTHOME="${XDG_CACHE_HOME}/pylint"

# Poetry
# export POETRY_CONFIG_DIR="${XDG_CONFIG_HOME}/pypoetry"
# export POETRY_DATA_DIR="${XDG_DATA_HOME}/pypoetry"
# export POETRY_CACHE_DIR="${XDG_CACHE_HOME}/pypoetry"

#
# Aliases
#

alias pip-req='pip install -r requirements.txt'
