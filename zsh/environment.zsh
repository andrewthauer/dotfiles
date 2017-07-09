#
# Customized environment settings
#

#
# Basics
#

autoload -Uz run-help
autoload -Uz add-zsh-hook
autoload -Uz is-at-least

#
# Smart URL's
#

autoload -Uz url-quote-magic
zle -N self-insert url-quote-magic

#
# Options
#

# Wait 10s for wildcard delete
# setopt RM_STAR_WAIT

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
# Completions
#

# Completion waiting dots
COMPLETION_WAITING_DOTS=true
