#
# Postgres
#

# Add postgres binaries to path
if [[ -d "/usr/local/opt/libpq/bin" ]]; then
  PATH="/usr/local/opt/libpq/bin:$PATH"
  # prepend_path "/usr/local/opt/libpq/bin"
fi
