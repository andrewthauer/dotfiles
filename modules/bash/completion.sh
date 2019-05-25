#
# Bash Completions
#

if [ -f /etc/bash_completion ]; then
  source /etc/bash_completion
elif [ -f $(brew --prefix)/etc/bash_completion ]; then
  source $(brew --prefix)/etc/bash_completion
fi
