#
# Initialize dotnet environment
#

if command_exists "dotnet"; then
  _dotnet_init() {
    # expensive operation
    DOTNET_ROOT="$(dirname $(command -v dotnet))"
    export MSBuildSDKsPath="${DOTNET_ROOT}/sdk/$(${DOTNET_ROOT}/dotnet --version)/Sdks"
    # prepend dotnet to the path if not already added
    prepend_path "${DOTNET_ROOT}"
    unset DOTNET_ROOT
  }

  # initialize dotnet (lazy)
  lazyfunc _dotnet_init "dotnet"

# Return if requirements not found
else
  return 1
fi
