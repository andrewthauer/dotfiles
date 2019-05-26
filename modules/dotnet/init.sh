#
# Initialize dotnet module
#

# Initialize dotnet
if [[ -x "$(command -v dotnet)" ]]; then
  # prepend dotnet to the path if not already added
  DOTNET_ROOT="$(dirname $(command -v dotnet))"
  [[ ":$PATH:" =~ ":$DOTNET_ROOT:" ]] || export PATH="$DOTNET_ROOT:$PATH"

  # Will only be executed on the first call to 'dotnet'
  dotnet() {
    # Remove this function, subsequent calls will execute directly
    unfunction "$0"

    # Expensive operation
    export MSBuildSDKsPath="${DOTNET_ROOT}/sdk/$(${DOTNET_ROOT}/dotnet --version)/Sdks"

    # Execute binary
    $0 "$@"
  }
fi
