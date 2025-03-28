# Check if gh is installed
if ! command_exists "gh"; then
  return 1
fi

# Refresh gh copilot aliases
init_gh_copilot() {
  local shell="zsh"
  local dir="${XDG_DATA_HOME}"/gh/shell.d
  local file="$dir/gh-copilot.$shell"

  # TODO: regenerate the alias file periodically
  if [ ! -f "$file" ]; then
    mkdir -p "$dir"
    gh copilot alias -- $shell >"$file"
  fi

  # shellcheck disable=SC1090
  source "$file"
}

init_gh_copilot 2>/dev/null || {
  return 1
}
