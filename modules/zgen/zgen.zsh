# Load prezto modules from zgen
zgen-prezto() {
  local repo="sorin-ionescu/prezto"
  local file="${1:-init.zsh}"
  zgen-load "$repo" "$file"
}
