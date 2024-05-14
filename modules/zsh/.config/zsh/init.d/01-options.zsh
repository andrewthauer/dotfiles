#
# ZSH Environment
#

# Basics
autoload -Uz run-help
autoload -Uz add-zsh-hook
autoload -Uz is-at-least

#
# General
#

setopt COMBINING_CHARS      # Combine zero-length punctuation characters (accents) with the base character
setopt INTERACTIVE_COMMENTS # Enable comments in interactive shell
setopt RC_QUOTES            # Allow 'Henry''s Garage' instead of 'Henry'\''s Garage'

#
# Jobs
#

# setopt LONG_LIST_JOBS     # List jobs in the long format by default
# setopt AUTO_RESUME        # Attempt to resume existing job before creating a new process
# setopt NOTIFY             # Report status of background jobs immediately
# unsetopt BG_NICE          # Don't run all background jobs at a lower priority
# unsetopt HUP              # Don't kill jobs on shell exit
# unsetopt CHECK_JOBS       # Don't report on jobs when shell exit

#
# Directories
#

setopt AUTO_CD           # Auto changes to a directory without typing cd
setopt AUTO_PUSHD        # Push the old directory onto the stack on cd
setopt PUSHD_IGNORE_DUPS # Do not store duplicates in the stack
setopt PUSHD_SILENT      # Do not print the directory stack after pushd or popd
setopt PUSHD_TO_HOME     # Push to home directory when no argument is given
setopt CDABLE_VARS       # Change directory to a path stored in a variable
setopt MULTIOS           # Write to multiple descriptors
setopt EXTENDED_GLOB     # Use extended globbing syntax
setopt NULL_GLOB         # Do not throw errors when file globs do not match anything
# setopt CSH_NULL_GLOB      # Only throw errors when no globs match anything

unsetopt AUTO_NAME_DIRS # Do not auto add variable-stored paths to ~ list
unsetopt CLOBBER        # Do not overwrite existing files with > and >>
# Use >! and >>! to bypass

#
# ZSH History
#

HISTFILE="${XDG_DATA_HOME}/zsh/history" # The path to the history file
HISTSIZE=10000                          # The maximum number of events to save in the internal history
SAVEHIST=10000                          # The maximum number of events to save in the history file

# Options
setopt BANG_HIST              # Treat the '!' character specially during expansion
setopt EXTENDED_HISTORY       # Write the history file in the ':start:elapsed;command' format
setopt INC_APPEND_HISTORY     # Write to the history file immediately, not when the shell exits
setopt SHARE_HISTORY          # Share history between all sessions
setopt HIST_EXPIRE_DUPS_FIRST # Expire a duplicate event first when trimming history
setopt HIST_IGNORE_DUPS       # Do not record an event that was just recorded again
setopt HIST_IGNORE_ALL_DUPS   # Delete an old recorded event if a new event is a duplicate
setopt HIST_FIND_NO_DUPS      # Do not display a previously found event
setopt HIST_IGNORE_SPACE      # Do not record an event starting with a space
setopt HIST_SAVE_NO_DUPS      # Do not write a duplicate event to the history file
setopt HIST_VERIFY            # Do not execute immediately upon history expansion
setopt HIST_BEEP              # Beep when accessing non-existent history

#
# History Substring Search
# - https://github.com/zsh-users/zsh-history-substring-search
# - NOTE: The plugin must be sourced after compinit
#

# Binding ^[[A/^[[B manually mean up/down works with history-substring-search both before and after zle-line-init
bindkey '^[[A' history-substring-search-up
bindkey '^[[B' history-substring-search-down

# Bind up and down keys
zmodload -F zsh/terminfo +p:terminfo
bindkey "${terminfo[kcuu1]}" history-substring-search-up
bindkey "${terminfo[kcud1]}" history-substring-search-down

zle -N history-substring-search-up
zle -N history-substring-search-down
