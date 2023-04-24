#
# Golang
#

# XDG configuration
export GOPATH="${XDG_DATA_HOME}/go"
export GOMODCACHE="${XDG_CACHE_HOME}/go/mod"

# Summary
#   Cleans up the go module cache
# Usage
#   go-clean-cache
go-clean-all() {
  # go clean -i: Remove the corresponding installed archive or binary (what ‘go install’ would create).

  # Clean recursively, i.e., apply the clean command to all dependencies.
  go clean -r

  # Clean the entire module cache (usually located in $GOPATH/pkg/mod), including both cached packages, builds, and cached downloaded modules.
  go clean -cache

  # Clean the entire test result cache.
  go clean -testcache

  # Clean the entire module download cache.
  go clean -modcache
}

# Summary
#   Cleans up the gopath bin directory
# Usage
#   go-clean-bin
go-clean-bin() {
  local go_path
  go_path="$(go env GOPATH)"

  if [ ! -d "${go_path}" ]; then
    echo "GOPATH not found"
    return 1
  fi

  rm "${go_path}"/bin/*
}
