#
# My additional aliases & overrides
#

#
# Shortcuts
#

alias dotdir="cd ${DOTFILES_DIR}"

#
# Directories
#

# Listing
alias l='ls -1A'         # Lists in one column, hidden files.
alias ll='ls -lh'        # Lists human readable sizes.
alias lr='ll -R'         # Lists human readable sizes, recursively.
alias la='ll -a'         # Lists human readable sizes, hidden files.
alias lm='la | "$PAGER"' # Lists human readable sizes, hidden files through pager.
alias lx='ll -XB'        # Lists sorted by extension (GNU only).
alias lk='ll -Sr'        # Lists sorted by size, largest last.
alias lt='ll -tr'        # Lists sorted by date, most recent last.
alias lc='lt -c'         # Lists sorted by date, most recent last, shows change time.
alias lu='lt -u'         # Lists sorted by date, most recent last, shows access time.

# Directory stack
alias d='dirs -v'

#
# Searching
#

alias findhere="find . -name"

#
# Diagnostics
#

# Alias psg="ps aux | grep -v grep | grep -i"
function psg() { ps aux | { head -1; grep -v grep | grep -i "$1"; } }

#
# Networking
#

alias lstcp="lsof -i -n -P | grep TCP"
