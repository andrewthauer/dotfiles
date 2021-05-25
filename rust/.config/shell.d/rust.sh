#
# Initialize rust environment
#
# - https://www.rust-lang.org
#

export CARGO_HOME="${XDG_DATA_HOME}/cargo"
export RUSTUP_HOME="${XDG_DATA_HOME}/rustup"

# Load rust manually
if [[ -d "${CARGO_HOME}/bin" ]]; then
  prepend_path "${CARGO_HOME}/bin"

# Return if requirements not found
else
  return 1
fi
