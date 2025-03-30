#
# Bash Completion
#

# Set the BASH_COMPLETION_COMPAT_DIR environment variable
_bash_completion_dir=(
  "${HOMEBREW_PREFIX}/etc/bash-completion.d"
)
for comp_dir in "${_bash_completion_dir[@]}"; do
  if [ -d "$comp_dir" ]; then
    export BASH_COMPLETION_COMPAT_DIR="$comp_dir"
    break
  fi
done
unset _bash_completion_dir

# Load bash completions
_bash_completion_paths=(
  "${HOMEBREW_PREFIX}/share/bash-completion/bash_completion"
  "${HOMEBREW_PREFIX}/etc/profile.d/bash_completion.sh"
  "/etc/bash_completion"
)
for comp_path in "${_bash_completion_paths[@]}"; do
  if [ -d "$comp_path" ]; then
    source_file "$comp_path"
    break
  fi
done
unset _bash_completion_paths

# Load custom completions
if [ -d "${XDG_DATA_HOME}/bash_completion.d" ]; then
  for file in "${XDG_DATA_HOME}"/bash_completion.d/*; do
    # shellcheck disable=SC1090
    source_file "$file"
  done
fi
