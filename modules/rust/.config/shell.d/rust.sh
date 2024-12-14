#
# Initialize rust environment
#
# - https://www.rust-lang.org
#

# Load rust manually
if [ -d "${CARGO_HOME}/bin" ]; then
  prepend_path "${CARGO_HOME}/bin"

# Return if requirements not found
else
  return 1
fi
