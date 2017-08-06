#
# Rust helpers & aliases
#

# add rust to path
if [[ -d "${HOME}/.cargo" ]]; then
  export PATH="${PATH}:$HOME/.cargo/bin"
fi
