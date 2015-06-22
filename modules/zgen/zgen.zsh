# Prezto directory
export ZPREZTODIR=$HOME/.zgen/sorin-ionescu/prezto-master

# Load prezto modules from zgen
zgen-prezto() {
  repo="sorin-ionescu/prezto"
  file="${1:-init.zsh}"
  zgen-load "$repo" "$file"
}
