#
# macOS Helpers
#

# Skip if not running on macOS
if [[ "$OSTYPE" != darwin* ]]; then
  return
fi

#
# Functions
#

rimraf_dsstore() {
  local search_path=$1
  if [ -v $1 ]; then
    search_path="."
  fi
  find "${search_path}" -iname ".DS_Store" -delete
}
