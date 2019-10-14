#
# Initialize AWS CLI environment
#

if [[ -d "${XDG_CONFIG_HOME}/aws" ]]; then
  export AWS_SHARED_CREDENTIALS_FILE="${XDG_CONFIG_HOME}/aws/credentials"
  export AWS_CONFIG_FILE="${XDG_CONFIG_HOME}/aws/config"
fi
