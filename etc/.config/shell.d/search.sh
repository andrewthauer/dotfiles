#
# Search helpers
#

# Ripgrep config
export RIPGREP_CONFIG_PATH="${XDG_CONFIG_HOME}/ripgrep/ripgreprc"

# Extracts a list of unique top level directores from results list
alias dironly='cut -d "/" -f1 | sort -u'
