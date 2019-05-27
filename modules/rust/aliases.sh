#
# Rust aliases
#

# rustup completion generation
update-rust-completions() {
  rustup completions bash >| "${DOTFILES_MODULES_DIR}/rust/completions/bash/rustup"
  rustup completions zsh >| "${DOTFILES_MODULES_DIR}/rust/completions/zsh/_rustup"
}
