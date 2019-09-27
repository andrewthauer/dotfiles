#
# Initialize dotnet environment
#

_dotnet_init() {
  # expensive operation
  DOTNET_ROOT="$(dirname $(command -v dotnet))"
  export MSBuildSDKsPath="${DOTNET_ROOT}/sdk/$(${DOTNET_ROOT}/dotnet --version)/Sdks"
  # prepend dotnet to the path if not already added
  [[ ":$PATH:" =~ ":$DOTNET_ROOT:" ]] || export PATH="$DOTNET_ROOT:$PATH"
  unset DOTNET_ROOT
}

# initialize dotnet (lazy)
if command_exists "dotnet"; then
  lazyfunc _dotnet_init "dotnet"
else
  unset -f _dotnet_init
  return 1
fi

#
# XDG specifications
#

export DOTNET_CLI_HOME="${XDG_DATA_HOME}/dotnet"
export MONO_REGISTRY_PATH="${XDG_DATA_HOME}/mono/registry"
