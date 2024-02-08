#
# Initialize python environment
#
# = https://github.com/pyenv/pyenv
#

#
# XDG specifications
#

export PYTHONSTARTUP="${XDG_CONFIG_HOME}/python/pythonrc.py"
export PYLINTHOME="${XDG_CACHE_HOME}/pylint"

# Poetry
export POETRY_CONFIG_DIR=${XDG_CONFIG_HOME}/pypoetry
export POETRY_DATA_DIR="${XDG_DATA_HOME}/pypoetry"
export POETRY_CACHE_DIR="${XDG_CACHE_HOME}/pypoetry"

#
# Aliases
#

alias pip-req='pip install -r requirements.txt'
