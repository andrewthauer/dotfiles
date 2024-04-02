#
# Initialize environment for GitHub CLI
#

# Refresh gh copilot aliases

shell="zsh"
dir="${XDG_DATA_HOME}"/gh/shell.d
file="$dir/gh-copilot.$shell"

# TODO: regenerate the alias file periodically
if [ ! -f "$file" ]; then
  mkdir -p "$dir"
  gh copilot alias -- $shell >$file
fi

source $file
