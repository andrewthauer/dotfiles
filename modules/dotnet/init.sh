#
# Initialize dotnet module
#

# Initialize dotnet
if [[ -x "$(command -v dotnet)" ]]; then
  export DOTNET_ROOT="/usr/local/share/dotnet"
  export PATH="${PATH}:${DOTNET_ROOT}"

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
