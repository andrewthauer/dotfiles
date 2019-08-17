#
# Common profile settings
#

# Editor
export EDITOR=vim
export VISUAL="${EDITOR}"

# Colors
export CLICOLOR=1

# Pager
export PAGER='less'
export LESS='-F -g -i -M -R -S -w -X -z-4'
export LESSCHARSET='utf-8'

# Set the Less input preprocessor
if type lesspipe.sh >/dev/null 2>&1; then
  export LESSOPEN='|lesspipe.sh %s'
fi
