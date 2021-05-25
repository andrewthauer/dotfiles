#
# Initialize dotnet environment
#

# Use asdf if installed
if [[ -d "${XDG_DATA_HOME}/asdf/plugins/dotnet-core" ]]; then
  echo "using asdf" >/dev/null

# Use system installed version
elif command_exists "dotnet"; then
  _dotnet_init() {
    # expensive operation
    DOTNET_ROOT="$(dirname "$(command -v dotnet)")"
    MSBuildSDKsPath="${DOTNET_ROOT}/sdk/$("${DOTNET_ROOT}"/dotnet --version)/Sdks"
    export MSBuildSDKsPath
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
