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
# unsetopt MAIL_WARNING       # Don't print a warning message if a mail file has been accessed.

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

#
# Prompt
#

# Disable auto correct
unsetopt CORRECT
unsetopt CORRECT_ALL
DISABLE_CORRECTION=true

# ZSH syntax highlighting
ZSH_HIGHLIGHT_HIGHLIGHTERS=(main brackets pattern cursor)

#
# Smart URLs
#

# This logic comes from an old version of zim. Essentially, bracketed-paste was
# added as a requirement of url-quote-magic in 5.1, but in 5.1.1 bracketed
# paste had a regression. Additionally, 5.2 added bracketed-paste-url-magic
# which is generally better than url-quote-magic so we load that when possible.
if [[ ${ZSH_VERSION} != 5.1.1 ]]; then
  if is-at-least 5.2; then
    autoload -Uz bracketed-paste-url-magic
    zle -N bracketed-paste bracketed-paste-url-magic
  else
    if is-at-least 5.1; then
      autoload -Uz bracketed-paste-magic
      zle -N bracketed-paste bracketed-paste-magic
    fi
  fi
  autoload -Uz url-quote-magic
  zle -N self-insert url-quote-magic
fi
