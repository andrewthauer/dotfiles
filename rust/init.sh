#
# Initialize Rust environment
#

# Initialize rust
if [[ -x "$(command -v rustc)" || -s "${HOME}/.cargo" ]]; then
  export PATH="${HOME}/.cargo/bin:${PATH}"
fi

# Load rust completions for zsh
if [[ -x "$(command -v rustc)" ]]; then
  fpath=($fpath "${DOTFILES_DIR}/rust/completions")
fi
