#
# My additional aliases & overrides
#

#
# Dotfiles
#

alias dotfiles="${DOTFILES_DIR}"
alias src="source ~/.zshrc"

#
# Directories
#

# alias l="ls -lhA"
# alias lt="ls -ltA"
# alias mkdir="mkdir -p"
alias rm="${aliases[rm]:-rm}"

alias d='dirs -v'
for index ({1..9}) alias "$index"="cd +${index}"; unset index

#
# Searching
#

alias findhere="find . -name"

#
# Diagnostics
#

alias psg="ps aux | grep -v grep | grep -i"
