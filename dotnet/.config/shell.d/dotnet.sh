#
# Initialize dotnet environment
#

# Use asdf if installed
if [[ -d "${XDG_DATA_HOME}/asdf/plugins/dotnet-core" ]]; then
  echo "using asdf" >/dev/null

elif command_exists "dotnet"; then
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

#
# XDG specifications
#

export DOTNET_CLI_HOME="${XDG_DATA_HOME}/dotnet"
export MONO_REGISTRY_PATH="${XDG_DATA_HOME}/mono/registry"
