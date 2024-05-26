#
# ZSH Key Bindings
#
# - http://zsh.sourceforge.net/Doc/Release/Zsh-Line-Editor.html
# - http://zsh.sourceforge.net/Doc/Release/Zsh-Line-Editor.html#Zle-Builtins
# - http://zsh.sourceforge.net/Doc/Release/Zsh-Line-Editor.html#Standard-Widgets
# - https://pubs.opengroup.org/onlinepubs/7908799/xcurses/terminfo.html
#

# Make sure that the terminal is in application mode when zle is active, since
# only then values from $terminfo are valid
if (( ${+terminfo[smkx]} )) && (( ${+terminfo[rmkx]} )); then
  function zle-line-init() {
    echoti smkx
  }
  function zle-line-finish() {
    echoti rmkx
  }
  zle -N zle-line-init
  zle -N zle-line-finish
fi

# Key bindings to use
# bindkey -e   # Use emacs key bindings
bindkey -v   # Use vi key bindings

#
# Cursor Movement
#

bindkey '^[w' forward-word
bindkey '^[b' backward-word

bindkey '^x' delete-char
bindkey '^?' backward-delete-char
bindkey '^h' backward-delete-char

# bindkey '^b' kill-word
bindkey '^L' kill-word
bindkey '^w' backward-kill-word
bindkey '^H' backward-kill-word # ctrl+bspc
bindkey '^[^?' backward-kill-word # alt+bspc

bindkey '^a' beginning-of-line
bindkey '^e' end-of-line
bindkey "${terminfo[khome]}" beginning-of-line
bindkey "${terminfo[kend]}" end-of-line

#
# History
#

# [Space] - do history expansion
bindkey ' ' magic-space

# bindkey '^P' up-line-or-history
# bindkey '^P' down-line-or-history
# bindkey "${terminfo[kpp]}" up-line-or-history         # page up
# bindkey "${terminfo[knp]}" down-line-or-history       # page down

bindkey '^P' history-search-backward
bindkey '^N' history-search-forward
bindkey "${terminfo[kcuu1]}" history-search-backward  # up key
bindkey "${terminfo[kcud1]}" history-search-forward   # down key

# bindkey '^r' history-incremental-search-backward

# start typing + kindbind for fuzzy find history backward
autoload -U down-line-or-beginning-search
zle -N down-line-or-beginning-search
bindkey '^P' down-line-or-beginning-search
bindkey "${terminfo[kcud1]}" down-line-or-beginning-search

# start typing + keybind for fuzzy find history forward
autoload -U up-line-or-beginning-search
zle -N up-line-or-beginning-search
bindkey '^N' up-line-or-beginning-search
bindkey "${terminfo[kcuu1]}" up-line-or-beginning-search

#
# Other helpers
#

# [Shift-Tab] - move through the completion menu backwards
bindkey "${terminfo[kcbt]}" reverse-menu-complete

# Edit the current command line in $EDITOR
autoload -U edit-command-line
zle -N edit-command-line
bindkey '^xe' edit-command-line
bindkey '^x^e' edit-command-line
