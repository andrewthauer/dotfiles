#
# Bash Prompt
#
# Based on: https://github.com/davidtwco/dotfiles/blob/master/.bash_prompt
#

# Colors
BLACK="$(tput setaf 0)"
RED="$(tput setaf 1)"
GREEN="$(tput setaf 2)"
YELLOW="$(tput setaf 3)"
BLUE="$(tput setaf 4)"
MAGENTA="$(tput setaf 5)"
CYAN="$(tput setaf 6)"
WHITE="$(tput setaf 7)"
BRIGHT_BLACK="$(tput setaf 8)"
BRIGHT_RED="$(tput setaf 9)"
BRIGHT_GREEN="$(tput setaf 10)"
BRIGHT_YELLOW="$(tput setaf 11)"
BRIGHT_BLUE="$(tput setaf 12)"
BRIGHT_MAGENTA="$(tput setaf 13)"
BRIGHT_CYAN="$(tput setaf 14)"
BRIGHT_WHITE="$(tput setaf 15)"
BOLD="$(tput bold)"
UNDERLINE="$(tput sgr 0 1)"
INVERT="$(tput sgr 1 0)"
RESET="$(tput sgr0)"
NOCOLOR="$RESET"

# Symbols
prompt_symbol="❯"
prompt_clean_symbol="☀ "
prompt_dirty_symbol="☂ "
prompt_venv_symbol="☁ "

function prompt_command() {
  # Git branch name and work tree status (only when we are inside Git working tree)
  local git_prompt=
  if [[ "true" = "$(git rev-parse --is-inside-work-tree 2>/dev/null)" ]]; then
    # Branch name
    local branch="$(git symbolic-ref HEAD 2>/dev/null)"
    branch="${branch##refs/heads/}"

    # Working tree status (red when dirty)
    local dirty=
    # Modified files
    git diff --no-ext-diff --quiet --exit-code --ignore-submodules 2>/dev/null || dirty=1
    # Untracked files
    [ -z "$dirty" ] && test -n "$(git status --porcelain)" && dirty=1

    # Format Git info
    if [ -n "$dirty" ]; then
      git_prompt=" $WHITE$prompt_dirty_symbol$branch$NOCOLOR"
    else
      git_prompt=" $WHITE$prompt_clean_symbol$branch$NOCOLOR"
    fi
  fi

  # Virtualenv
  local venv_prompt=
  if [ -n "$VIRTUAL_ENV" ]; then
    venv_prompt=" $BLUE$prompt_venv_symbol$(basename $VIRTUAL_ENV)$NOCOLOR"
  fi

  # Show user & hostname inside SSH session
  local login_prompt=
  if [ -n "$SSH_CLIENT" ] || [ -n "$SSH_TTY" ]; then
    login_prompt="$YELLOW$USER@$HOSTNAME$NOCOLOR "
  fi

  # Format prompt
  first_line="$login_prompt$BLUE\w$NOCOLOR$git_prompt$venv_prompt"
  # Text (commands) inside \[...\] does not impact line length calculation which fixes stange bug when looking through the history
  # $? is a status of last command, should be processed every time prompt prints
  second_line="\`if [ \$? = 0 ]; then echo \[\$RED\]; else echo \[\$RED\]; fi\`\$prompt_symbol\[\$NOCOLOR\] "

  # Bash outputs the vi mode string at the start of the final line.
  # Therefore, if enabled, we will have two prompt strings, one that displays
  # the usual success/error of previous command, and one that indicates the
  # vi mode.
  PS1="\n$first_line\n$second_line"
  PS2="\[$CYAN\]$prompt_symbol\[$NOCOLOR\] "

  # Terminal title
  local title="$(basename "$PWD")"
  [ -n "$remote" ] && title="$title \xE2\x80\x94 $HOSTNAME"
  echo -ne "\033]0;$title"; echo -ne "\007"
}

# Show prompt only if Git is installed.
command -v git >/dev/null 2>&1 && PROMPT_COMMAND=prompt_command
