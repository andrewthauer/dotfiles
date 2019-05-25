#
# Initialize rust module
#

# Initialize rust
if [[ -x "$(command -v rustc)" || -s "${HOME}/.cargo" ]]; then
  export PATH="${HOME}/.cargo/bin:${PATH}"
fi
