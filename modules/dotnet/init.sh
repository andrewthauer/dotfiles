#
# Initialize dotnet module
#

_dotnet_init() {
  # expensive operation
  DOTNET_ROOT="$(dirname $(command -v dotnet))"
  export MSBuildSDKsPath="${DOTNET_ROOT}/sdk/$(${DOTNET_ROOT}/dotnet --version)/Sdks"

  # prepend dotnet to the path if not already added
  [[ ":$PATH:" =~ ":$DOTNET_ROOT:" ]] || export PATH="$DOTNET_ROOT:$PATH"

  unset -f "$0"
}

_dotnet_lazy_init() {
  dotnet() { unset -f "$0"; _dotnet_init; $0 "$@"; }
}

# initialize dotnet (lazy)
if command_exists "dotnet"; then
  _dotnet_lazy_init
fi
