# Common system aliases

# Common aliases
alias dotfiles="${DOTPATH}"

# directories
alias cd..="cd .."
alias l="ls -la"
alias ll="ls -lhA"
alias lt="ls -ltA"
alias lsl="ls -lhA | ${PAGER}"
alias mkdir="mkdir -p"

# find here
alias fhere="find . -name"

# process
alias psg="ps aux | grep -v grep | grep -i"

# reloading
alias src="source ~/.zshrc"
