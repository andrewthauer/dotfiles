#
# Initialize dotnet environment
#

# Initialize dotnet
if [[ -x "$(command -v dotnet)" ]]; then
  export DOTNET_ROOT=/usr/local/share/dotnet
  export MSBuildSDKsPath=$DOTNET_ROOT/sdk/$(${DOTNET_ROOT}/dotnet --version)/Sdks
  export PATH=${PATH}:${DOTNET_ROOT}
fi
