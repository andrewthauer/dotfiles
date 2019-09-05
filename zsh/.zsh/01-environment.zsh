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

setopt COMBINING_CHARS      # Combine zero-length punctuation characters (accents) with the base character.
setopt INTERACTIVE_COMMENTS # Enable comments in interactive shell.
setopt RC_QUOTES            # Allow 'Henry''s Garage' instead of 'Henry'\''s Garage'.

#
# Jobs
#

# setopt LONG_LIST_JOBS     # List jobs in the long format by default.
# setopt AUTO_RESUME        # Attempt to resume existing job before creating a new process.
# setopt NOTIFY             # Report status of background jobs immediately.
# unsetopt BG_NICE          # Don't run all background jobs at a lower priority.
# unsetopt HUP              # Don't kill jobs on shell exit.
# unsetopt CHECK_JOBS       # Don't report on jobs when shell exit.

#
# Directories
#

setopt AUTO_CD              # Auto changes to a directory without typing cd.
setopt AUTO_PUSHD           # Push the old directory onto the stack on cd.
setopt PUSHD_IGNORE_DUPS    # Do not store duplicates in the stack.
setopt PUSHD_SILENT         # Do not print the directory stack after pushd or popd.
setopt PUSHD_TO_HOME        # Push to home directory when no argument is given.
setopt CDABLE_VARS          # Change directory to a path stored in a variable.
setopt MULTIOS              # Write to multiple descriptors.
setopt EXTENDED_GLOB        # Use extended globbing syntax.

unsetopt AUTO_NAME_DIRS     # Do not auto add variable-stored paths to ~ list.
unsetopt CLOBBER            # Do not overwrite existing files with > and >>.
                            # Use >! and >>! to bypass.
