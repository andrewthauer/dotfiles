#
# Initialize dotnet module
#

_dotnet_init() {
  # expensive operation
  DOTNET_ROOT="$(dirname $(command -v dotnet))"
  export MSBuildSDKsPath="${DOTNET_ROOT}/sdk/$(${DOTNET_ROOT}/dotnet --version)/Sdks"

  # prepend dotnet to the path if not already added
  [[ ":$PATH:" =~ ":$DOTNET_ROOT:" ]] || export PATH="$DOTNET_ROOT:$PATH"
}

# initialize dotnet (lazy)
if command_exists "dotnet"; then
  __lazyfunc _dotnet_init "dotnet"
fi
