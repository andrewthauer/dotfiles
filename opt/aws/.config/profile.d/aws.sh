#
# Initialize AWS CLI environment
#

if [[ -d "${XDG_CONFIG_HOME}/aws" ]]; then
  export AWS_SHARED_CREDENTIALS_FILE="${XDG_CONFIG_HOME}/aws/shared-credentials"
  export AWS_CONFIG_FILE="${XDG_CONFIG_HOME}/aws/config"
  export AWS_CLI_HISTORY_FILE="$XDG_DATA_HOME/aws/history"
  export AWS_CREDENTIALS_FILE="${XDG_CONFIG_HOME}/aws/credentials"
  export AWS_WEB_IDENTITY_TOKEN_FILE="${XDG_CONFIG_HOME}/aws/token"
fi
