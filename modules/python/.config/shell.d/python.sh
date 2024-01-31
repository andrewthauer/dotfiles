#
# Initialize python environment
#
# = https://github.com/pyenv/pyenv
#

# XDG specifications
export PYTHONSTARTUP="${XDG_CONFIG_HOME}/python/pythonrc.py"
export PYLINTHOME="${XDG_CACHE_HOME}/pylint"

# Aliases
alias pip-req='pip install -r requirements.txt'
